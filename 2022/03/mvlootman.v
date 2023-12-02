import os
import arrays { chunk, sum }

const offset = 96

fn main() {
	rucksacks := os.read_lines('rucksack.input')!

	part1 := sum(rucksacks.map(process_rucksack))!

	mut groups_of_three := chunk(rucksacks, 3)
	part2 := sum(groups_of_three.map(find_badge_prio(it)))!

	println('Part 1: ${part1}\nPart 2: ${part2}')
}

fn process_rucksack(rucksack string) int {
	if rucksack.len % 2 != 0 {
		panic('invalid rucksack :${rucksack}')
	}

	left := rucksack[..rucksack.len / 2]
	right := rucksack[rucksack.len / 2..]

	for sl in left {
		for sr in right {
			if sl == sr {
				// println('match: ${sl.ascii_str()} ->  sl:${sl} sr:${sr} prio:${sl - offset} convert:${convert_prio(sl)}')
				return convert_prio(sl)
			}
		}
	}

	return 0
}

fn find_badge_prio(rucksack_group []string) int {
	first, second, third := rucksack_group[0], rucksack_group[1], rucksack_group[2]

	for b in first {
		if second.contains(b.ascii_str()) && third.contains(b.ascii_str()) {
			// println('badge: ${b.ascii_str()} ->  b:${b} convert:${convert_prio(b)}')
			return convert_prio(b)
		}
	}
	panic('no item was encountered atleast 3 times')
}

fn convert_prio(byte_val u8) int {
	r := match byte_val {
		`A`...`Z` { byte_val - `A` + 27 } // Uppercase item types A through Z have priorities 27 through 52.
		`a`...`z` { byte_val - `a` + 1 } // Lowercase item types a through z have priorities 1 through 26.
		else { panic('invalid byte ${byte_val}') }
	}
	return int(r)
}
