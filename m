Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292877AbSB0VYi>; Wed, 27 Feb 2002 16:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292968AbSB0VYN>; Wed, 27 Feb 2002 16:24:13 -0500
Received: from mother.ludd.luth.se ([130.240.16.3]:26289 "EHLO
	mother.ludd.luth.se") by vger.kernel.org with ESMTP
	id <S292958AbSB0VX2>; Wed, 27 Feb 2002 16:23:28 -0500
Date: Wed, 27 Feb 2002 22:23:25 +0100 (MET)
From: texas <texas@ludd.luth.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
In-Reply-To: <E16gAJn-0005fo-00@the-village.bc.nu>
Message-ID: <Pine.GSU.4.33.0202272221050.23720-100000@father.ludd.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Make sure you have all the pnp os settings disabled in the bios

Yes, they are disabled.

> HT but not hyperthreading activated in the kernel (acpismp=force).

Hyperthreading were disabled in the BIOS. It's the default setting in
"fail safe" but curiously also in "optimized settings".

It is now enabled together with the acpismp=force in lilo. Note however
that the "WARNING: No sibling found" messages are still there. Strange?

The newly compiled kernel is without highmem as suggested and the BIOS
values for UDMA have been updated (the reason they showed UDMA33 were
because of "fail safe" BIOS settings, sorry for missing that).

> See if a single CPU kernel is reliable

I will if this highmem off setting doesn't fix it. I really need both
working or the load will skyrocket :-(

>Ensure your ventilation is fine and your PSU is approved

Both are excellent, should not be an issue.

The new boot messages, with acpismp=force and HT enabled in BIOS, note new
ACPI messages, like "Searched entire block, no RSDP was found". Problem?



Feb 27 22:07:16 db2 kernel: Linux version 2.4.18-rc4 (root@db2) (gcc
version 2.95.3 20010315 (release)) #1 SMP Wed Feb 27 22:03:01 CET 2002
Feb 27 22:07:16 db2 kernel: BIOS-provided physical RAM map:
Feb 27 22:07:16 db2 kernel:  BIOS-e820: 0000000000000000 -
00000000000a0000 (usable)
Feb 27 22:07:16 db2 kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Feb 27 22:07:16 db2 kernel:  BIOS-e820: 0000000000100000 -
0000000040000000 (usable)
Feb 27 22:07:16 db2 kernel:  BIOS-e820: 00000000fec00000 -
0000000100000000 (reserved)
Feb 27 22:07:16 db2 kernel: Warning only 896MB will be used.
Feb 27 22:07:16 db2 kernel: Use a HIGHMEM enabled kernel.
Feb 27 22:07:16 db2 kernel: found SMP MP-table at 000f5010
Feb 27 22:07:16 db2 kernel: hm, page 000f5000 reserved twice.
Feb 27 22:07:16 db2 kernel: hm, page 000f6000 reserved twice.
Feb 27 22:07:16 db2 kernel: hm, page 000f1000 reserved twice.
Feb 27 22:07:16 db2 kernel: hm, page 000f2000 reserved twice.
Feb 27 22:07:16 db2 kernel: On node 0 totalpages: 229376
Feb 27 22:07:16 db2 kernel: zone(0): 4096 pages.
Feb 27 22:07:16 db2 kernel: zone(1): 225280 pages.
Feb 27 22:07:16 db2 kernel: zone(2): 0 pages.
Feb 27 22:07:16 db2 kernel: ACPI: Searched entire block, no RSDP was
found.
Feb 27 22:07:16 db2 kernel: ACPI: Searched entire block, no RSDP was
found.
Feb 27 22:07:16 db2 kernel: ACPI: System description tables not found
Feb 27 22:07:16 db2 kernel: Intel MultiProcessor Specification v1.4
Feb 27 22:07:16 db2 kernel:     Virtual Wire compatibility mode.
Feb 27 22:07:16 db2 kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC
at: 0xFEE00000
Feb 27 22:07:16 db2 kernel: Processor #0 Unknown CPU [15:2] APIC version
17
Feb 27 22:07:16 db2 kernel: Processor #1 Unknown CPU [15:2] APIC version
17
Feb 27 22:07:16 db2 kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Feb 27 22:07:16 db2 kernel: Processors: 2
Feb 27 22:07:16 db2 kernel: Kernel command line: auto BOOT_IMAGE=linux ro
root=301 acpismp=force
Feb 27 22:07:16 db2 kernel: Initializing CPU#0
Feb 27 22:07:16 db2 kernel: Detected 1982.543 MHz processor.
Feb 27 22:07:16 db2 kernel: Console: colour VGA+ 80x25
Feb 27 22:07:16 db2 kernel: Calibrating delay loop... 3958.37 BogoMIPS
Feb 27 22:07:16 db2 kernel: Memory: 901096k/917504k available (808k kernel
code, 16024k reserved, 183k data, 212k init, 0k highmem)
Feb 27 22:07:16 db2 kernel: Dentry-cache hash table entries: 131072
(order: 8, 1048576 bytes)
Feb 27 22:07:16 db2 kernel: Inode-cache hash table entries: 65536 (order:
7, 524288 bytes)
Feb 27 22:07:16 db2 kernel: Mount-cache hash table entries: 16384 (order:
5, 131072 bytes)
Feb 27 22:07:16 db2 kernel: Buffer-cache hash table entries: 65536 (order:
6, 262144 bytes)
Feb 27 22:07:16 db2 kernel: Page-cache hash table entries: 262144 (order:
8, 1048576 bytes)
Feb 27 22:07:16 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 27 22:07:16 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 27 22:07:16 db2 kernel: CPU: L2 cache: 512K
Feb 27 22:07:16 db2 kernel: CPU: Physical Processor ID: 0
Feb 27 22:07:16 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: Intel machine check architecture supported.
Feb 27 22:07:16 db2 kernel: Intel machine check reporting enabled on
CPU#0.
Feb 27 22:07:16 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: Enabling fast FPU save and restore... done.
Feb 27 22:07:16 db2 kernel: Enabling unmasked SIMD FPU exception
support... done.
Feb 27 22:07:16 db2 kernel: Checking 'hlt' instruction... OK.
Feb 27 22:07:16 db2 kernel: POSIX conformance testing by UNIFIX
Feb 27 22:07:16 db2 kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Feb 27 22:07:16 db2 kernel: mtrr: detected mtrr type: Intel
Feb 27 22:07:16 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 27 22:07:16 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 27 22:07:16 db2 kernel: CPU: L2 cache: 512K
Feb 27 22:07:16 db2 kernel: CPU: Physical Processor ID: 0
Feb 27 22:07:16 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: Intel machine check reporting enabled on
CPU#0.
Feb 27 22:07:16 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: CPU0: Intel(R) XEON(TM) CPU 2.00GHz stepping
04
Feb 27 22:07:16 db2 kernel: per-CPU timeslice cutoff: 1463.19 usecs.
Feb 27 22:07:16 db2 kernel: enabled ExtINT on CPU#0
Feb 27 22:07:16 db2 kernel: ESR value before enabling vector: 00000000
Feb 27 22:07:16 db2 kernel: ESR value after enabling vector: 00000000
Feb 27 22:07:16 db2 kernel: Booting processor 1/1 eip 2000
Feb 27 22:07:16 db2 kernel: Initializing CPU#1
Feb 27 22:07:16 db2 kernel: masked ExtINT on CPU#1
Feb 27 22:07:16 db2 kernel: ESR value before enabling vector: 00000000
Feb 27 22:07:16 db2 kernel: ESR value after enabling vector: 00000000
Feb 27 22:07:16 db2 kernel: Calibrating delay loop... 3958.37 BogoMIPS
Feb 27 22:07:16 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 27 22:07:16 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 27 22:07:16 db2 kernel: CPU: L2 cache: 512K
Feb 27 22:07:16 db2 kernel: CPU: Physical Processor ID: 3
Feb 27 22:07:16 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: Intel machine check reporting enabled on
CPU#1.
Feb 27 22:07:16 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 27 22:07:16 db2 kernel: CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping
04
Feb 27 22:07:16 db2 kernel: Total of 2 processors activated (7916.74
BogoMIPS).
Feb 27 22:07:16 db2 kernel: WARNING: No sibling found for CPU 0.
Feb 27 22:07:16 db2 kernel: WARNING: No sibling found for CPU 1.
Feb 27 22:07:16 db2 kernel: ENABLING IO-APIC IRQs
Feb 27 22:07:16 db2 kernel: Setting 2 in the phys_id_present_map
Feb 27 22:07:16 db2 kernel: ...changing IO-APIC physical APIC ID to 2 ...
ok.
Feb 27 22:07:16 db2 kernel: init IO_APIC IRQs
Feb 27 22:07:16 db2 kernel:  IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-12,
2-17, 2-18, 2-20, 2-21, 2-22 not connected.
Feb 27 22:07:16 db2 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Feb 27 22:07:16 db2 kernel: number of MP IRQ sources: 18.
Feb 27 22:07:17 db2 kernel: number of IO-APIC #2 registers: 24.
Feb 27 22:07:17 db2 kernel: testing the IO APIC.......................
Feb 27 22:07:17 db2 kernel:
Feb 27 22:07:17 db2 kernel: IO APIC #2......
Feb 27 22:07:17 db2 kernel: .... register #00: 02000000
Feb 27 22:07:17 db2 kernel: .......    : physical APIC id: 02
Feb 27 22:07:17 db2 kernel: .... register #01: 00178020
Feb 27 22:07:17 db2 kernel: .......     : max redirection entries: 0017
Feb 27 22:07:17 db2 kernel: .......     : PRQ implemented: 1
Feb 27 22:07:17 db2 kernel: .......     : IO APIC version: 0020
Feb 27 22:07:17 db2 kernel: .... register #02: 00000000
Feb 27 22:07:17 db2 kernel: .......     : arbitration: 00
Feb 27 22:07:17 db2 kernel: .... IRQ redirection table:
Feb 27 22:07:17 db2 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli
Vect:
Feb 27 22:07:17 db2 kernel:  00 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  01 003 03  0    0    0   0   0    1    1
39
Feb 27 22:07:17 db2 kernel:  02 003 03  0    0    0   0   0    1    1
31
Feb 27 22:07:17 db2 kernel:  03 003 03  0    0    0   0   0    1    1
41
Feb 27 22:07:17 db2 kernel:  04 003 03  0    0    0   0   0    1    1
49
Feb 27 22:07:17 db2 kernel:  05 003 03  0    0    0   0   0    1    1
51
Feb 27 22:07:17 db2 kernel:  06 003 03  0    0    0   0   0    1    1
59
Feb 27 22:07:17 db2 kernel:  07 003 03  0    0    0   0   0    1    1
61
Feb 27 22:07:17 db2 kernel:  08 003 03  0    0    0   0   0    1    1
69
Feb 27 22:07:17 db2 kernel:  09 003 03  0    0    0   0   0    1    1
71
Feb 27 22:07:17 db2 kernel:  0a 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  0b 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  0c 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  0d 003 03  0    0    0   0   0    1    1
79
Feb 27 22:07:17 db2 kernel:  0e 003 03  0    0    0   0   0    1    1
81
Feb 27 22:07:17 db2 kernel:  0f 003 03  0    0    0   0   0    1    1
89
Feb 27 22:07:17 db2 kernel:  10 003 03  1    1    0   1   0    1    1
91
Feb 27 22:07:17 db2 kernel:  11 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  12 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  13 003 03  1    1    0   1   0    1    1
99
Feb 27 22:07:17 db2 kernel:  14 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  15 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  16 000 00  1    0    0   0   0    0    0
00
Feb 27 22:07:17 db2 kernel:  17 003 03  1    1    0   1   0    1    1
A1
Feb 27 22:07:17 db2 kernel: IRQ to pin mappings:
Feb 27 22:07:17 db2 kernel: IRQ0 -> 0:2
Feb 27 22:07:17 db2 kernel: IRQ1 -> 0:1
Feb 27 22:07:17 db2 kernel: IRQ3 -> 0:3
Feb 27 22:07:17 db2 kernel: IRQ4 -> 0:4
Feb 27 22:07:17 db2 kernel: IRQ5 -> 0:5
Feb 27 22:07:17 db2 kernel: IRQ6 -> 0:6
Feb 27 22:07:17 db2 kernel: IRQ7 -> 0:7
Feb 27 22:07:17 db2 kernel: IRQ8 -> 0:8
Feb 27 22:07:17 db2 kernel: IRQ9 -> 0:9
Feb 27 22:07:17 db2 kernel: IRQ13 -> 0:13
Feb 27 22:07:17 db2 kernel: IRQ14 -> 0:14
Feb 27 22:07:17 db2 kernel: IRQ15 -> 0:15
Feb 27 22:07:17 db2 kernel: IRQ16 -> 0:16
Feb 27 22:07:17 db2 kernel: IRQ19 -> 0:19
Feb 27 22:07:17 db2 kernel: IRQ23 -> 0:23
Feb 27 22:07:17 db2 kernel: .................................... done.
Feb 27 22:07:17 db2 kernel: Using local APIC timer interrupts.
Feb 27 22:07:17 db2 kernel: calibrating APIC timer ...
Feb 27 22:07:17 db2 kernel: ..... CPU clock speed is 1982.5340 MHz.
Feb 27 22:07:17 db2 kernel: ..... host bus clock speed is 99.1265 MHz.
Feb 27 22:07:17 db2 kernel: cpu: 0, clocks: 991265, slice: 330421
Feb 27 22:07:17 db2 kernel:
CPU0<T0:991264,T1:660832,D:11,S:330421,C:991265>
Feb 27 22:07:17 db2 kernel: cpu: 1, clocks: 991265, slice: 330421
Feb 27 22:07:17 db2 kernel:
CPU1<T0:991264,T1:330416,D:6,S:330421,C:991265>
Feb 27 22:07:17 db2 kernel: checking TSC synchronization across CPUs:
passed.
Feb 27 22:07:17 db2 kernel: Waiting on wait_init_idle (map = 0x2)
Feb 27 22:07:17 db2 kernel: All processors have done init_idle
Feb 27 22:07:17 db2 kernel: mtrr: your CPUs had inconsistent fixed MTRR
settings
Feb 27 22:07:17 db2 kernel: mtrr: probably your BIOS does not setup all
CPUs
Feb 27 22:07:17 db2 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb3e0,
last bus=4
Feb 27 22:07:17 db2 kernel: PCI: Using configuration type 1
Feb 27 22:07:17 db2 kernel: PCI: Probing PCI hardware
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 0: assuming
transparent
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 1: assuming
transparent
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 0: assuming
transparent
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 0: assuming
transparent
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 27 22:07:17 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 27 22:07:17 db2 kernel: PCI: Using IRQ router PIIX [8086/2440] at
00:1f.0
Feb 27 22:07:17 db2 kernel: PCI->APIC IRQ transform: (B0,I31,P1) -> 19
Feb 27 22:07:17 db2 kernel: PCI->APIC IRQ transform: (B4,I3,P0) -> 19
Feb 27 22:07:17 db2 kernel: PCI->APIC IRQ transform: (B4,I4,P0) -> 16
Feb 27 22:07:17 db2 kernel: Linux NET4.0 for Linux 2.4
Feb 27 22:07:17 db2 kernel: Based upon Swansea University Computer Society
NET3.039
Feb 27 22:07:17 db2 kernel: Initializing RT netlink socket
Feb 27 22:07:17 db2 kernel: Starting kswapd
Feb 27 22:07:17 db2 kernel: Real Time Clock Driver v1.10e
Feb 27 22:07:17 db2 kernel: block: 128 slots per queue, batch=32
Feb 27 22:07:17 db2 kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Feb 27 22:07:17 db2 kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Feb 27 22:07:17 db2 kernel: PIIX4: IDE controller on PCI bus 00 dev f9
Feb 27 22:07:17 db2 kernel: PIIX4: chipset revision 4
Feb 27 22:07:17 db2 kernel: PIIX4: not 100%% native mode: will probe irqs
later
Feb 27 22:07:17 db2 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Feb 27 22:07:17 db2 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
settings: hdc:DMA, hdd:pio
Feb 27 22:07:17 db2 kernel: hda: WDC WD1000JB-32CWE0, ATA DISK drive
Feb 27 22:07:17 db2 kernel: hdc: WDC WD1000JB-32CWE0, ATA DISK drive
Feb 27 22:07:17 db2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 27 22:07:17 db2 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 27 22:07:17 db2 kernel: hda: 195371568 sectors (100030 MB) w/8192KiB
Cache, CHS=12161/255/63, UDMA(100)
Feb 27 22:07:17 db2 kernel: hdc: 195371568 sectors (100030 MB) w/8192KiB
Cache, CHS=193821/16/63, UDMA(100)
Feb 27 22:07:17 db2 kernel: Partition check:
Feb 27 22:07:17 db2 kernel:  hda: hda1 hda2 hda3 hda4
Feb 27 22:07:17 db2 kernel:  hdc: [PTBL] [12161/255/63] hdc1 hdc2 hdc3
hdc4
Feb 27 22:07:17 db2 kernel: Floppy drive(s): fd0 is 1.44M
Feb 27 22:07:17 db2 kernel: FDC 0 is a post-1991 82077
Feb 27 22:07:17 db2 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
Feb 27 22:07:17 db2 kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Feb 27 22:07:17 db2 kernel: eth0: OEM i82557/i82558 10/100 Ethernet,
00:30:48:21:B5:1A, IRQ 16.
Feb 27 22:07:17 db2 kernel:   Board assembly 000000-000, Physical
connectors present: RJ45
Feb 27 22:07:17 db2 kernel:   Primary interface chip i82555 PHY #1.
Feb 27 22:07:17 db2 kernel:   General self-test: passed.
Feb 27 22:07:17 db2 kernel:   Serial sub-system self-test: passed.
Feb 27 22:07:17 db2 kernel:   Internal registers self-test: passed.
Feb 27 22:07:17 db2 kernel:   ROM checksum self-test: passed (0x04f4518b).
Feb 27 22:07:17 db2 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 27 22:07:17 db2 kernel: IP Protocols: ICMP, UDP, TCP
Feb 27 22:07:17 db2 kernel: IP: routing cache hash table of 8192 buckets,
64Kbytes
Feb 27 22:07:17 db2 kernel: TCP: Hash tables configured (established
262144 bind 65536)
Feb 27 22:07:17 db2 kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Feb 27 22:07:17 db2 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Feb 27 22:07:17 db2 kernel: Freeing unused kernel memory: 212k freed
Feb 27 22:07:17 db2 kernel: Adding Swap: 104416k swap-space (priority -1)

