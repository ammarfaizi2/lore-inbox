Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSHHQZO>; Thu, 8 Aug 2002 12:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSHHQZO>; Thu, 8 Aug 2002 12:25:14 -0400
Received: from holomorphy.com ([66.224.33.161]:33177 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317624AbSHHQY7>;
	Thu, 8 Aug 2002 12:24:59 -0400
Date: Thu, 8 Aug 2002 09:28:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: further IO-APIC oddities
Message-ID: <20020808162856.GD6256@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strange thing happened when I booted the latest x86 discontigmem stuff.
The stuff where the IO-APIC ID's showed up as zeroed out went away,
and io_apic.c just bitched about the MPC table entries because it
doesn't realize that physid's of IO-APIC's mean squat on this box.

*AND* whatever was scribbling over that table & zeroing it out went
away. That bug is reproducible on more garden variety machines too.
If someone who knows how to read the IO-APIC map dumps is around,
I've included the boot log below.

Any pointers to where I should print_IO_APIC() early on would also be
useful.


Cheers,
Bill


Linux version 2.5.30-wli-6 (wli@megeira) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Wed Aug 7 18:42:00 PDT 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000e0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000400000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 0000000000100000 - 00000000e0000000 (usable)
 user: 00000000fec00000 - 00000000fec09000 (reserved)
 user: 00000000ffe80000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000400000000 (usable)
15488MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 1048576
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 819200 pages.
On node 1 totalpages: 1048576
zone(0): 0 pages.
zone(1): 0 pages.
zone(2): 1048576 pages.
On node 2 totalpages: 1048576
zone(0): 0 pages.
zone(1): 0 pages.
zone(2): 1048576 pages.
On node 3 totalpages: 1048576
zone(0): 0 pages.
zone(1): 0 pages.
zone(2): 1048576 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          APIC at: 0xFEC08000
Found an OEM MPC table at   7009c8 - parsing it ... 
Translation: record 0, type 1, quad 0, global 3, local 3
Translation: record 1, type 1, quad 0, global 1, local 1
Translation: record 2, type 1, quad 0, global 1, local 1
Translation: record 3, type 1, quad 0, global 1, local 1
Translation: record 4, type 1, quad 1, global 1, local 3
Translation: record 5, type 1, quad 1, global 1, local 1
Translation: record 6, type 1, quad 1, global 1, local 1
Translation: record 7, type 1, quad 1, global 1, local 1
Translation: record 8, type 1, quad 2, global 1, local 3
Translation: record 9, type 1, quad 2, global 1, local 1
Translation: record 10, type 1, quad 2, global 1, local 1
Translation: record 11, type 1, quad 2, global 1, local 1
Translation: record 12, type 1, quad 3, global 1, local 3
Translation: record 13, type 1, quad 3, global 1, local 1
Translation: record 14, type 1, quad 3, global 1, local 1
Translation: record 15, type 1, quad 3, global 1, local 1
Translation: record 16, type 3, quad 0, global 0, local 0
Translation: record 17, type 3, quad 0, global 1, local 1
Translation: record 18, type 3, quad 0, global 2, local 2
Translation: record 19, type 4, quad 0, global 12, local 18
Translation: record 20, type 3, quad 1, global 3, local 0
Translation: record 21, type 3, quad 1, global 4, local 1
Translation: record 22, type 3, quad 1, global 5, local 2
Translation: record 23, type 4, quad 1, global 13, local 18
Translation: record 24, type 3, quad 2, global 6, local 0
Translation: record 25, type 3, quad 2, global 7, local 1
Translation: record 26, type 3, quad 2, global 8, local 2
Translation: record 27, type 4, quad 2, global 14, local 18
Translation: record 28, type 3, quad 3, global 9, local 0
Translation: record 29, type 3, quad 3, global 10, local 1
Translation: record 30, type 3, quad 3, global 11, local 2
Translation: record 31, type 4, quad 3, global 15, local 18
Translation: record 32, type 2, quad 0, global 13, local 14
Translation: record 33, type 2, quad 0, global 14, local 13
Translation: record 34, type 2, quad 1, global 15, local 14
Translation: record 35, type 2, quad 1, global 16, local 13
Translation: record 36, type 2, quad 2, global 17, local 14
Translation: record 37, type 2, quad 2, global 18, local 13
Translation: record 38, type 2, quad 3, global 19, local 14
Translation: record 39, type 2, quad 3, global 20, local 13
Processor #0 6:10 APIC version 17 (quad 0, apic 1)
Processor #4 6:10 APIC version 17 (quad 0, apic 8)
Processor #1 6:10 APIC version 17 (quad 0, apic 2)
Processor #2 6:10 APIC version 17 (quad 0, apic 4)
Processor #0 6:10 APIC version 17 (quad 1, apic 17)
Processor #4 6:10 APIC version 17 (quad 1, apic 24)
Processor #1 6:10 APIC version 17 (quad 1, apic 18)
Processor #2 6:10 APIC version 17 (quad 1, apic 20)
Processor #0 6:10 APIC version 17 (quad 2, apic 33)
Processor #4 6:10 APIC version 17 (quad 2, apic 40)
Processor #1 6:10 APIC version 17 (quad 2, apic 34)
Processor #2 6:10 APIC version 17 (quad 2, apic 36)
Processor #0 6:10 APIC version 17 (quad 3, apic 49)
Processor #4 6:10 APIC version 17 (quad 3, apic 56)
Processor #1 6:10 APIC version 17 (quad 3, apic 50)
Processor #2 6:10 APIC version 17 (quad 3, apic 52)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #2 is PCI    (node 0)
Bus #12 is EISA   (node 0)
Bus #3 is PCI    (node 1)
Bus #4 is PCI    (node 1)
Bus #5 is PCI    (node 1)
Bus #13 is EISA   (node 1)
Bus #6 is PCI    (node 2)
Bus #7 is PCI    (node 2)
Bus #8 is PCI    (node 2)
Bus #14 is EISA   (node 2)
Bus #9 is PCI    (node 3)
Bus #10 is PCI    (node 3)
Bus #11 is PCI    (node 3)
Bus #15 is EISA   (node 3)
I/O APIC #13 Version 17 at 0xFE800000.
I/O APIC #14 Version 17 at 0xFE801000.
I/O APIC #15 Version 17 at 0xFE840000.
I/O APIC #16 Version 17 at 0xFE841000.
I/O APIC #17 Version 17 at 0xFE880000.
I/O APIC #18 Version 17 at 0xFE881000.
I/O APIC #19 Version 17 at 0xFE8C0000.
I/O APIC #20 Version 17 at 0xFE8C1000.
Processors: 16
Kernel command line: root=/dev/sda2 console=ttyS0,38400n8 mem=16777216K
Initializing CPU#0
Loading GDT/IDT for CPU#0
Loaded per-cpu LDT/TSS for CPU#0
Cleaned up FPU and debug regs for CPU#0
Detected 700.291 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1380.35 BogoMIPS
Initializing highpages for node 0
Initializing highpages for node 1
Initializing highpages for node 2
Initializing highpages for node 3
Memory: 16068224k/18393268k available (1388k kernel code, 123520k reserved, 542k data, 260k init, 15335424k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Remapping cross-quad port I/O for 4 quads
xquad_portio vaddr 0x00000000, len 00200000
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel 00/0a stepping 04
per-CPU timeslice cutoff: 5846.34 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Booting processor 1/2 eip 2000
Initializing CPU#1
Loading GDT/IDT for CPU#1
Loaded per-cpu LDT/TSS for CPU#1
Cleaned up FPU and debug regs for CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Calibrating delay loop... 1396.73 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 2/4 eip 2000
Initializing CPU#2
Loading GDT/IDT for CPU#2
Loaded per-cpu LDT/TSS for CPU#2
Cleaned up FPU and debug regs for CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Calibrating delay loop... 1396.73 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU2: Intel 00/0a stepping 00
Restoring NMI vector
Booting processor 3/8 eip 2000
Initializing CPU#3
Loading GDT/IDT for CPU#3
Loaded per-cpu LDT/TSS for CPU#3
Cleaned up FPU and debug regs for CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Calibrating delay loop... 1396.73 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU3: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 4/17 eip 2000
Initializing CPU#4
Loading GDT/IDT for CPU#4
Loaded per-cpu LDT/TSS for CPU#4
Cleaned up FPU and debug regs for CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU4: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 5/18 eip 2000
Initializing CPU#5
Loading GDT/IDT for CPU#5
Loaded per-cpu LDT/TSS for CPU#5
Cleaned up FPU and debug regs for CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU5: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 6/20 eip 2000
Initializing CPU#6
Loading GDT/IDT for CPU#6
Loaded per-cpu LDT/TSS for CPU#6
Cleaned up FPU and debug regs for CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU6: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 7/24 eip 2000
Initializing CPU#7
Loading GDT/IDT for CPU#7
Loaded per-cpu LDT/TSS for CPU#7
Cleaned up FPU and debug regs for CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Calibrating delay loop... 1388.54 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU7: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 8/33 eip 2000
Initializing CPU#8
Loading GDT/IDT for CPU#8
Loaded per-cpu LDT/TSS for CPU#8
Cleaned up FPU and debug regs for CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Calibrating delay loop... 1388.54 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU8: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 9/34 eip 2000
Initializing CPU#9
Loading GDT/IDT for CPU#9
Loaded per-cpu LDT/TSS for CPU#9
Cleaned up FPU and debug regs for CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU9: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 10/36 eip 2000
Initializing CPU#10
Loading GDT/IDT for CPU#10
Loaded per-cpu LDT/TSS for CPU#10
Cleaned up FPU and debug regs for CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU10: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 11/40 eip 2000
Initializing CPU#11
Loading GDT/IDT for CPU#11
Loaded per-cpu LDT/TSS for CPU#11
Cleaned up FPU and debug regs for CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU11: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 12/49 eip 2000
Initializing CPU#12
Loading GDT/IDT for CPU#12
Loaded per-cpu LDT/TSS for CPU#12
Cleaned up FPU and debug regs for CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Calibrating delay loop... 1388.54 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU12: Intel 00/0a stepping 00
Restoring NMI vector
Booting processor 13/50 eip 2000
Initializing CPU#13
Loading GDT/IDT for CPU#13
Loaded per-cpu LDT/TSS for CPU#13
Cleaned up FPU and debug regs for CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU13: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 14/52 eip 2000
Initializing CPU#14
Loading GDT/IDT for CPU#14
Loaded per-cpu LDT/TSS for CPU#14
Cleaned up FPU and debug regs for CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU14: Intel 00/0a stepping 00
Restoring NMI vector
Booting processor 15/56 eip 2000
Initializing CPU#15
Loading GDT/IDT for CPU#15
Loaded per-cpu LDT/TSS for CPU#15
Cleaned up FPU and debug regs for CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU15: Intel 00/0a stepping 00
Restoring NMI vector
Total of 16 processors activated (22269.95 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
Setting 14 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 14 ... ok.
BIOS bug, IO-APIC#2 ID is 15 in the MPC table!...
... fixing up to 14. (tell your hw vendor)
BIOS bug, IO-APIC#2 ID 14 is already used!...
... fixing up to 4. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 4 ... ok.
BIOS bug, IO-APIC#3 ID is 16 in the MPC table!...
... fixing up to 13. (tell your hw vendor)
BIOS bug, IO-APIC#3 ID 13 is already used!...
... fixing up to 5. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 5 ... ok.
BIOS bug, IO-APIC#4 ID is 17 in the MPC table!...
... fixing up to 14. (tell your hw vendor)
BIOS bug, IO-APIC#4 ID 14 is already used!...
... fixing up to 6. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 6 ... ok.
BIOS bug, IO-APIC#5 ID is 18 in the MPC table!...
... fixing up to 13. (tell your hw vendor)
BIOS bug, IO-APIC#5 ID 13 is already used!...
... fixing up to 7. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 7 ... ok.
BIOS bug, IO-APIC#6 ID is 19 in the MPC table!...
... fixing up to 14. (tell your hw vendor)
BIOS bug, IO-APIC#6 ID 14 is already used!...
... fixing up to 8. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 8 ... ok.
BIOS bug, IO-APIC#7 ID is 20 in the MPC table!...
... fixing up to 13. (tell your hw vendor)
BIOS bug, IO-APIC#7 ID 13 is already used!...
... fixing up to 9. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 9 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 13-0, 14-0, 14-8, 14-18, 14-19, 14-20, 14-21, 14-22, 14-23, 4-0, 5-0, 5-8, 5-18, 5-19, 5-20, 5-21, 5-22, 5-23, 6-0, 7-0, 7-8, 7-18, 7-19, 7-20, 7-21, 7-22, 7-23, 8-0, 9-0, 9-8, 9-18, 9-19, 9-20, 9-21, 9-22, 9-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 160.
number of IO-APIC #13 registers: 24.
number of IO-APIC #14 registers: 24.
number of IO-APIC #4 registers: 24.
number of IO-APIC #5 registers: 24.
number of IO-APIC #6 registers: 24.
number of IO-APIC #7 registers: 24.
number of IO-APIC #8 registers: 24.
number of IO-APIC #9 registers: 24.
testing the IO APIC.......................

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 00F 0F  0    0    0   0   0    0    1    31
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    61
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    81
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    91
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    A1
 10 00F 0F  1    1    0   1   0    0    1    A9
 11 00F 0F  1    1    0   1   0    0    1    B1
 12 00F 0F  1    1    0   1   0    0    1    B9
 13 00F 0F  1    1    0   1   0    0    1    C1
 14 00F 0F  1    1    0   1   0    0    1    C9
 15 00F 0F  1    1    0   1   0    0    1    D1
 16 00F 0F  1    1    0   1   0    0    1    D9
 17 00F 0F  1    1    0   1   0    0    1    E1

IO APIC #14......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    E9
 02 00F 0F  1    1    0   1   0    0    1    32
 03 00F 0F  1    1    0   1   0    0    1    3A
 04 00F 0F  1    1    0   1   0    0    1    42
 05 00F 0F  1    1    0   1   0    0    1    4A
 06 00F 0F  1    1    0   1   0    0    1    52
 07 00F 0F  1    1    0   1   0    0    1    5A
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    62
 0a 00F 0F  1    1    0   1   0    0    1    6A
 0b 00F 0F  1    1    0   1   0    0    1    72
 0c 00F 0F  1    1    0   1   0    0    1    7A
 0d 00F 0F  1    1    0   1   0    0    1    82
 0e 00F 0F  1    1    0   1   0    0    1    8A
 0f 00F 0F  1    1    0   1   0    0    1    92
 10 00F 0F  1    1    0   1   0    0    1    9A
 11 00F 0F  1    1    0   1   0    0    1    A2
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    AA
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    B2
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    BA
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    C2
 10 00F 0F  1    1    0   1   0    0    1    CA
 11 00F 0F  1    1    0   1   0    0    1    D2
 12 00F 0F  1    1    0   1   0    0    1    DA
 13 00F 0F  1    1    0   1   0    0    1    E2
 14 00F 0F  1    1    0   1   0    0    1    EA
 15 00F 0F  1    1    0   1   0    0    1    33
 16 00F 0F  1    1    0   1   0    0    1    3B
 17 00F 0F  1    1    0   1   0    0    1    43

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 05000000
.......     : arbitration: 05
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    4B
 02 00F 0F  1    1    0   1   0    0    1    53
 03 00F 0F  1    1    0   1   0    0    1    5B
 04 00F 0F  1    1    0   1   0    0    1    63
 05 00F 0F  1    1    0   1   0    0    1    6B
 06 00F 0F  1    1    0   1   0    0    1    73
 07 00F 0F  1    1    0   1   0    0    1    7B
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    83
 0a 00F 0F  1    1    0   1   0    0    1    8B
 0b 00F 0F  1    1    0   1   0    0    1    93
 0c 00F 0F  1    1    0   1   0    0    1    9B
 0d 00F 0F  1    1    0   1   0    0    1    A3
 0e 00F 0F  1    1    0   1   0    0    1    AB
 0f 00F 0F  1    1    0   1   0    0    1    B3
 10 00F 0F  1    1    0   1   0    0    1    BB
 11 00F 0F  1    1    0   1   0    0    1    C3
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #6......
.... register #00: 06000000
.......    : physical APIC id: 06
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 06000000
.......     : arbitration: 06
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    CB
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    D3
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    DB
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    E3
 10 00F 0F  1    1    0   1   0    0    1    EB
 11 00F 0F  1    1    0   1   0    0    1    34
 12 00F 0F  1    1    0   1   0    0    1    3C
 13 00F 0F  1    1    0   1   0    0    1    44
 14 00F 0F  1    1    0   1   0    0    1    4C
 15 00F 0F  1    1    0   1   0    0    1    54
 16 00F 0F  1    1    0   1   0    0    1    5C
 17 00F 0F  1    1    0   1   0    0    1    64

IO APIC #7......
.... register #00: 07000000
.......    : physical APIC id: 07
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 07000000
.......     : arbitration: 07
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    6C
 02 00F 0F  1    1    0   1   0    0    1    74
 03 00F 0F  1    1    0   1   0    0    1    7C
 04 00F 0F  1    1    0   1   0    0    1    84
 05 00F 0F  1    1    0   1   0    0    1    8C
 06 00F 0F  1    1    0   1   0    0    1    94
 07 00F 0F  1    1    0   1   0    0    1    9C
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    A4
 0a 00F 0F  1    1    0   1   0    0    1    AC
 0b 00F 0F  1    1    0   1   0    0    1    B4
 0c 00F 0F  1    1    0   1   0    0    1    BC
 0d 00F 0F  1    1    0   1   0    0    1    C4
 0e 00F 0F  1    1    0   1   0    0    1    CC
 0f 00F 0F  1    1    0   1   0    0    1    D4
 10 00F 0F  1    1    0   1   0    0    1    DC
 11 00F 0F  1    1    0   1   0    0    1    E4
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 08000000
.......     : arbitration: 08
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    EC
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    35
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    3D
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    45
 10 00F 0F  1    1    0   1   0    0    1    4D
 11 00F 0F  1    1    0   1   0    0    1    55
 12 00F 0F  1    1    0   1   0    0    1    5D
 13 00F 0F  1    1    0   1   0    0    1    65
 14 00F 0F  1    1    0   1   0    0    1    6D
 15 00F 0F  1    1    0   1   0    0    1    75
 16 00F 0F  1    1    0   1   0    0    1    7D
 17 00F 0F  1    1    0   1   0    0    1    85

IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 09000000
.......     : arbitration: 09
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    8D
 02 00F 0F  1    1    0   1   0    0    1    95
 03 00F 0F  1    1    0   1   0    0    1    9D
 04 00F 0F  1    1    0   1   0    0    1    A5
 05 00F 0F  1    1    0   1   0    0    1    AD
 06 00F 0F  1    1    0   1   0    0    1    B5
 07 00F 0F  1    1    0   1   0    0    1    BD
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    C5
 0a 00F 0F  1    1    0   1   0    0    1    CD
 0b 00F 0F  1    1    0   1   0    0    1    D5
 0c 00F 0F  1    1    0   1   0    0    1    DD
 0d 00F 0F  1    1    0   1   0    0    1    E5
 0e 00F 0F  1    1    0   1   0    0    1    ED
 0f 00F 0F  1    1    0   1   0    0    1    36
 10 00F 0F  1    1    0   1   0    0    1    3E
 11 00F 0F  1    1    0   1   0    0    1    46
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1-> 2:1-> 4:1-> 6:1
IRQ3 -> 0:3-> 2:3-> 4:3-> 6:3
IRQ4 -> 0:4-> 2:4-> 4:4-> 6:4
IRQ5 -> 0:5-> 2:5-> 4:5-> 6:5
IRQ6 -> 0:6-> 2:6-> 4:6-> 6:6
IRQ7 -> 0:7
IRQ8 -> 0:8-> 2:8-> 4:8-> 6:8
IRQ9 -> 0:9-> 2:9-> 4:9-> 6:9
IRQ10 -> 0:10-> 2:10-> 4:10-> 6:10
IRQ11 -> 0:11
IRQ12 -> 0:12-> 2:12-> 4:12-> 6:12
IRQ13 -> 0:13
IRQ14 -> 0:14-> 2:14-> 4:14-> 6:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 1:4
IRQ29 -> 1:5
IRQ30 -> 1:6
IRQ31 -> 1:7
IRQ33 -> 1:9
IRQ34 -> 1:10
IRQ35 -> 1:11
IRQ36 -> 1:12
IRQ37 -> 1:13
IRQ38 -> 1:14
IRQ39 -> 1:15
IRQ40 -> 1:16
IRQ41 -> 1:17
IRQ55 -> 2:7
IRQ59 -> 2:11
IRQ61 -> 2:13
IRQ63 -> 2:15
IRQ64 -> 2:16
IRQ65 -> 2:17
IRQ66 -> 2:18
IRQ67 -> 2:19
IRQ68 -> 2:20
IRQ69 -> 2:21
IRQ70 -> 2:22
IRQ71 -> 2:23
IRQ73 -> 3:1
IRQ74 -> 3:2
IRQ75 -> 3:3
IRQ76 -> 3:4
IRQ77 -> 3:5
IRQ78 -> 3:6
IRQ79 -> 3:7
IRQ81 -> 3:9
IRQ82 -> 3:10
IRQ83 -> 3:11
IRQ84 -> 3:12
IRQ85 -> 3:13
IRQ86 -> 3:14
IRQ87 -> 3:15
IRQ88 -> 3:16
IRQ89 -> 3:17
IRQ103 -> 4:7
IRQ107 -> 4:11
IRQ109 -> 4:13
IRQ111 -> 4:15
IRQ112 -> 4:16
IRQ113 -> 4:17
IRQ114 -> 4:18
IRQ115 -> 4:19
IRQ116 -> 4:20
IRQ117 -> 4:21
IRQ118 -> 4:22
IRQ119 -> 4:23
IRQ121 -> 5:1
IRQ122 -> 5:2
IRQ123 -> 5:3
IRQ124 -> 5:4
IRQ125 -> 5:5
IRQ126 -> 5:6
IRQ127 -> 5:7
IRQ129 -> 5:9
IRQ130 -> 5:10
IRQ131 -> 5:11
IRQ132 -> 5:12
IRQ133 -> 5:13
IRQ134 -> 5:14
IRQ135 -> 5:15
IRQ136 -> 5:16
IRQ137 -> 5:17
IRQ151 -> 6:7
IRQ155 -> 6:11
IRQ157 -> 6:13
IRQ159 -> 6:15
IRQ160 -> 6:16
IRQ161 -> 6:17
IRQ162 -> 6:18
IRQ163 -> 6:19
IRQ164 -> 6:20
IRQ165 -> 6:21
IRQ166 -> 6:22
IRQ167 -> 6:23
IRQ169 -> 7:1
IRQ170 -> 7:2
IRQ171 -> 7:3
IRQ172 -> 7:4
IRQ173 -> 7:5
IRQ174 -> 7:6
IRQ175 -> 7:7
IRQ177 -> 7:9
IRQ178 -> 7:10
IRQ179 -> 7:11
IRQ180 -> 7:12
IRQ181 -> 7:13
IRQ182 -> 7:14
IRQ183 -> 7:15
IRQ184 -> 7:16
IRQ185 -> 7:17
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0941 MHz.
..... host bus clock speed is 99.0991 MHz.
cpu: 0, clocks: 99991, slice: 3030
CPU0<T0:99984,T1:96944,D:10,S:3030,C:99991>
checking TSC synchronization across 16 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has -36624 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has -36624 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has -36624 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has -36624 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has -20041 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has -20041 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has -20041 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has -20041 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 19867 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has 19867 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 19867 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 19868 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has 36798 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has 36798 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has 36798 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has 36798 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 99991, slice: 3030
CPU1<T0:99984,T1:93920,D:4,S:3030,C:99991>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
cpu: 2, clocks: 99991, slice: 3030
CPU2<T0:99984,T1:90880,D:14,S:3030,C:99991>
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
cpu: 3, clocks: 99991, slice: 3030
CPU3<T0:99984,T1:87856,D:8,S:3030,C:99991>
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
cpu: 4, clocks: 99991, slice: 3030
CPU4<T0:99984,T1:84832,D:2,S:3030,C:99991>
CPU 4 IS NOW UP!
Starting migration thread for cpu 4
Bringing up 5
cpu: 5, clocks: 99991, slice: 3030
CPU5<T0:99984,T1:81792,D:12,S:3030,C:99991>
CPU 5 IS NOW UP!
Starting migration thread for cpu 5
Bringing up 6
cpu: 6, clocks: 99991, slice: 3030
CPU6<T0:99984,T1:78768,D:6,S:3030,C:99991>
CPU 6 IS NOW UP!
Starting migration thread for cpu 6
Bringing up 7
cpu: 7, clocks: 99991, slice: 3030
CPU7<T0:99984,T1:75744,D:0,S:3030,C:99991>
CPU 7 IS NOW UP!
Starting migration thread for cpu 7
Bringing up 8
cpu: 8, clocks: 99991, slice: 3030
CPU8<T0:99984,T1:72704,D:10,S:3030,C:99991>
CPU 8 IS NOW UP!
Starting migration thread for cpu 8
Bringing up 9
cpu: 9, clocks: 99991, slice: 3030
CPU9<T0:99984,T1:69680,D:4,S:3030,C:99991>
CPU 9 IS NOW UP!
Starting migration thread for cpu 9
Bringing up 10
cpu: 10, clocks: 99991, slice: 3030
CPU10<T0:99984,T1:66640,D:14,S:3030,C:99991>
CPU 10 IS NOW UP!
Starting migration thread for cpu 10
Bringing up 11
cpu: 11, clocks: 99991, slice: 3030
CPU11<T0:99984,T1:63616,D:8,S:3030,C:99991>
CPU 11 IS NOW UP!
Starting migration thread for cpu 11
Bringing up 12
cpu: 12, clocks: 99991, slice: 3030
CPU12<T0:99984,T1:60592,D:2,S:3030,C:99991>
CPU 12 IS NOW UP!
Starting migration thread for cpu 12
Bringing up 13
cpu: 13, clocks: 99991, slice: 3030
CPU13<T0:99984,T1:57552,D:12,S:3030,C:99991>
CPU 13 IS NOW UP!
Starting migration thread for cpu 13
Bringing up 14
cpu: 14, clocks: 99991, slice: 3030
CPU14<T0:99984,T1:54528,D:6,S:3030,C:99991>
CPU 14 IS NOW UP!
Starting migration thread for cpu 14
Bringing up 15
cpu: 15, clocks: 99991, slice: 3030
CPU15<T0:99984,T1:51504,D:0,S:3030,C:99991>
CPU 15 IS NOW UP!
Starting migration thread for cpu 15
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd231, last bus=2
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 00:10.0
Unknown bridge resource 2: assuming transparent
Scanning PCI bus 3 for quad 1
Scanning PCI bus 6 for quad 2
Scanning PCI bus 9 for quad 3
PCI->APIC IRQ transform: (B0,I10,P0) -> 23
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B2,I15,P0) -> 28
PCI: using PPB(B0,I12,P0) to get irq 15
PCI->APIC IRQ transform: (B1,I4,P0) -> 15
PCI: using PPB(B0,I12,P1) to get irq 13
PCI->APIC IRQ transform: (B1,I5,P1) -> 13
PCI: using PPB(B0,I12,P2) to get irq 11
PCI->APIC IRQ transform: (B1,I6,P2) -> 11
PCI: using PPB(B0,I12,P3) to get irq 7
PCI->APIC IRQ transform: (B1,I7,P3) -> 7
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Capability LSM initialized
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: no supported devices found.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: no supported devices found.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.3.1 20020611 on minor 1
block: 256 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 (unofficial 2.2/2.4 kernel port, version 1.03+LK1.3.6, March 7, 2002)
eth0: Adaptec Starfire 6915 at 0xf8a01000, 00:00:d1:ec:cf:9d, IRQ 15.
eth0: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth0: scatter-gather and hardware TCP cksumming disabled.
eth1: Adaptec Starfire 6915 at 0xf8a82000, 00:00:d1:ec:cf:9e, IRQ 13.
eth1: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth1: scatter-gather and hardware TCP cksumming disabled.
eth2: Adaptec Starfire 6915 at 0xf8b03000, 00:00:d1:ec:cf:9f, IRQ 11.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth2: scatter-gather and hardware TCP cksumming disabled.
eth3: Adaptec Starfire 6915 at 0xf8b84000, 00:00:d1:ec:cf:a0, IRQ 7.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth3: scatter-gather and hardware TCP cksumming disabled.
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 58 irq 19 MEM base 0xf8c05000
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM OEM   Model: DCHS09X           Rev: 5454
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM OEM   Model: DCHS09X           Rev: 5454
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
 sda: sda1 sda2
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: unknown partition table
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
 sdc: unknown partition table
SCSI device sdd: 17796077 512-byte hdwr sectors (9112 MB)
 sdd: sdd1 sdd2
SCSI device sde: 17796077 512-byte hdwr sectors (9112 MB)
 sde: sde1 < >
SCSI device sdf: 35843670 512-byte hdwr sectors (18352 MB)
 sdf: unknown partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 65536 buckets, 1024Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 260k freed
eth0: Link is down
