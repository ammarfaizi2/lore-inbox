Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293143AbSB1DIT>; Wed, 27 Feb 2002 22:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293159AbSB1DHh>; Wed, 27 Feb 2002 22:07:37 -0500
Received: from mother.ludd.luth.se ([130.240.16.3]:49630 "EHLO
	mother.ludd.luth.se") by vger.kernel.org with ESMTP
	id <S293143AbSB1DHV>; Wed, 27 Feb 2002 22:07:21 -0500
Date: Thu, 28 Feb 2002 04:07:18 +0100 (MET)
From: texas <texas@ludd.luth.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
In-Reply-To: <E16gC11-0005zS-00@the-village.bc.nu>
Message-ID: <Pine.GSU.4.33.0202280355460.24329-100000@father.ludd.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry having to admit this but I had ACPI turned off in BIOS. Turned
it back on and now hyperthreading seems to work and "top" gives me four
processors! Damn that's sweet :-)

I can't say anything about added performance though as that has to be
tested during peak hours. With 15833.49 bogomips, it has to be good ;-)

Only time can tell what happened to the random lockups though, hopefully
they will go away as highmem were turned off and "resources controlled by"
in BIOS were set to "manual" instead of "auto(ESCD)".

Below is the boot messages when HT is working. Some strange messages like
"no RSDP was found" and then "RSDP located at physical address c00f6bf0"
are present as well as "init.c:148: bad pte 3fff3163" but none seem
serious.

Thanks,
Johan


Feb 28 02:17:50 db2 kernel: Linux version 2.4.18-rc4 (root@db2) (gcc
version 2.95.3 20010315 (release)) #1 SMP Wed Feb 27 22:03:01 CET 2002
Feb 28 02:17:50 db2 kernel: BIOS-provided physical RAM map:
Feb 28 02:17:50 db2 kernel:  BIOS-e820: 0000000000000000 -
00000000000a0000 (usable)
Feb 28 02:17:50 db2 kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Feb 28 02:17:50 db2 kernel:  BIOS-e820: 0000000000100000 -
000000003fff0000 (usable)
Feb 28 02:17:50 db2 kernel:  BIOS-e820: 000000003fff0000 -
000000003fff3000 (ACPI NVS)
Feb 28 02:17:50 db2 kernel:  BIOS-e820: 000000003fff3000 -
0000000040000000 (ACPI data)
Feb 28 02:17:50 db2 kernel:  BIOS-e820: 00000000fec00000 -
0000000100000000 (reserved)
Feb 28 02:17:50 db2 kernel: Warning only 896MB will be used.
Feb 28 02:17:50 db2 kernel: Use a HIGHMEM enabled kernel.
Feb 28 02:17:50 db2 kernel: found SMP MP-table at 000f5010
Feb 28 02:17:50 db2 kernel: hm, page 000f5000 reserved twice.
Feb 28 02:17:50 db2 kernel: hm, page 000f6000 reserved twice.
Feb 28 02:17:50 db2 kernel: hm, page 000f1000 reserved twice.
Feb 28 02:17:50 db2 kernel: hm, page 000f2000 reserved twice.
Feb 28 02:17:50 db2 kernel: On node 0 totalpages: 229376
Feb 28 02:17:50 db2 kernel: zone(0): 4096 pages.
Feb 28 02:17:50 db2 kernel: zone(1): 225280 pages.
Feb 28 02:17:50 db2 kernel: zone(2): 0 pages.
Feb 28 02:17:50 db2 kernel: ACPI: Searched entire block, no RSDP was
found.
Feb 28 02:17:50 db2 kernel: ACPI: RSDP located at physical address
c00f6bf0
Feb 28 02:17:50 db2 kernel: RSD PTR  v0 [IntelR]
Feb 28 02:17:50 db2 kernel: ACPI table found: RSDT v1 [IntelR AWRDACPI
16944.11825]
Feb 28 02:17:50 db2 kernel: init.c:148: bad pte 3fff3163.
Feb 28 02:17:50 db2 kernel: ACPI table found: FACP v1 [IntelR AWRDACPI
16944.11825]
Feb 28 02:17:50 db2 kernel: init.c:148: bad pte 3fff3163.
Feb 28 02:17:50 db2 kernel: ACPI table found: APIC v1 [IntelR AWRDACPI
16944.11825]
Feb 28 02:17:50 db2 kernel: init.c:148: bad pte 3fff6163.
Feb 28 02:17:50 db2 kernel: LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
Feb 28 02:17:50 db2 kernel: CPU 0 (0x0000) enabledProcessor #0 Unknown CPU
[15:2] APIC version 16
Feb 28 02:17:50 db2 kernel:
Feb 28 02:17:50 db2 kernel: LAPIC (acpi_id[0x0001] id[0x1] enabled[1])
Feb 28 02:17:50 db2 kernel: CPU 1 (0x0100) enabledProcessor #1 Unknown CPU
[15:2] APIC version 16
Feb 28 02:17:50 db2 kernel:
Feb 28 02:17:50 db2 kernel: LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
Feb 28 02:17:50 db2 kernel: CPU 2 (0x0200) enabledProcessor #2 Unknown CPU
[15:2] APIC version 16
Feb 28 02:17:50 db2 kernel:
Feb 28 02:17:50 db2 kernel: LAPIC (acpi_id[0x0003] id[0x3] enabled[1])
Feb 28 02:17:50 db2 kernel: CPU 3 (0x0300) enabledProcessor #3 Unknown CPU
[15:2] APIC version 16
Feb 28 02:17:50 db2 kernel:
Feb 28 02:17:50 db2 kernel: IOAPIC (id[0x2] address[0xfec00000]
global_irq_base[0x0])
Feb 28 02:17:50 db2 kernel: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2]
polarity[0x1] trigger[0x3])
Feb 28 02:17:50 db2 kernel: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9]
polarity[0x1] trigger[0x3])
Feb 28 02:17:50 db2 kernel: 4 CPUs total
Feb 28 02:17:50 db2 kernel: Local APIC address fee00000
Feb 28 02:17:50 db2 kernel: Enabling the CPU's according to the ACPI table
Feb 28 02:17:50 db2 kernel: Intel MultiProcessor Specification v1.4
Feb 28 02:17:50 db2 kernel:     Virtual Wire compatibility mode.
Feb 28 02:17:50 db2 kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC
at: 0xFEE00000
Feb 28 02:17:50 db2 kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Feb 28 02:17:50 db2 kernel: Processors: 4
Feb 28 02:17:50 db2 kernel: init.c:148: bad pte 3fff6163.
Feb 28 02:17:50 db2 kernel: Kernel command line: auto BOOT_IMAGE=linux ro
root=301 acpismp=force
Feb 28 02:17:50 db2 kernel: Initializing CPU#0
Feb 28 02:17:50 db2 kernel: Detected 1982.583 MHz processor.
Feb 28 02:17:50 db2 kernel: Console: colour VGA+ 80x25
Feb 28 02:17:50 db2 kernel: Calibrating delay loop... 3958.37 BogoMIPS
Feb 28 02:17:50 db2 kernel: Memory: 901096k/917504k available (808k kernel
code, 16024k reserved, 183k data, 212k init, 0k highmem)
Feb 28 02:17:50 db2 kernel: Dentry-cache hash table entries: 131072
(order: 8, 1048576 bytes)
Feb 28 02:17:50 db2 kernel: Inode-cache hash table entries: 65536 (order:
7, 524288 bytes)
Feb 28 02:17:50 db2 kernel: Mount-cache hash table entries: 16384 (order:
5, 131072 bytes)
Feb 28 02:17:50 db2 kernel: Buffer-cache hash table entries: 65536 (order:
6, 262144 bytes)
Feb 28 02:17:50 db2 kernel: Page-cache hash table entries: 262144 (order:
8, 1048576 bytes)
Feb 28 02:17:50 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 28 02:17:50 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 28 02:17:50 db2 kernel: CPU: L2 cache: 512K
Feb 28 02:17:50 db2 kernel: CPU: Physical Processor ID: 0
Feb 28 02:17:50 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:50 db2 kernel: Intel machine check architecture supported.
Feb 28 02:17:50 db2 kernel: Intel machine check reporting enabled on
CPU#0.
Feb 28 02:17:50 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:50 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:50 db2 kernel: Enabling fast FPU save and restore... done.
Feb 28 02:17:50 db2 kernel: Enabling unmasked SIMD FPU exception
support... done.
Feb 28 02:17:50 db2 kernel: Checking 'hlt' instruction... OK.
Feb 28 02:17:50 db2 kernel: POSIX conformance testing by UNIFIX
Feb 28 02:17:50 db2 kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Feb 28 02:17:50 db2 kernel: mtrr: detected mtrr type: Intel
Feb 28 02:17:50 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 28 02:17:50 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 28 02:17:50 db2 kernel: CPU: L2 cache: 512K
Feb 28 02:17:50 db2 kernel: CPU: Physical Processor ID: 0
Feb 28 02:17:50 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:50 db2 kernel: Intel machine check reporting enabled on
CPU#0.
Feb 28 02:17:50 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:50 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:50 db2 kernel: CPU0: Intel(R) XEON(TM) CPU 2.00GHz stepping
04
Feb 28 02:17:50 db2 kernel: per-CPU timeslice cutoff: 1463.19 usecs.
Feb 28 02:17:50 db2 kernel: enabled ExtINT on CPU#0
Feb 28 02:17:50 db2 kernel: ESR value before enabling vector: 00000000
Feb 28 02:17:50 db2 kernel: ESR value after enabling vector: 00000000
Feb 28 02:17:51 db2 kernel: Booting processor 1/1 eip 2000
Feb 28 02:17:51 db2 kernel: Initializing CPU#1
Feb 28 02:17:51 db2 kernel: masked ExtINT on CPU#1
Feb 28 02:17:51 db2 kernel: ESR value before enabling vector: 00000000
Feb 28 02:17:51 db2 kernel: ESR value after enabling vector: 00000000
Feb 28 02:17:51 db2 kernel: Calibrating delay loop... 3958.37 BogoMIPS
Feb 28 02:17:51 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 28 02:17:51 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 28 02:17:51 db2 kernel: CPU: L2 cache: 512K
Feb 28 02:17:51 db2 kernel: CPU: Physical Processor ID: 3
Feb 28 02:17:51 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: Intel machine check reporting enabled on
CPU#1.
Feb 28 02:17:51 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping
04
Feb 28 02:17:51 db2 kernel: Booting processor 2/2 eip 2000
Feb 28 02:17:51 db2 kernel: Initializing CPU#2
Feb 28 02:17:51 db2 kernel: masked ExtINT on CPU#2
Feb 28 02:17:51 db2 kernel: ESR value before enabling vector: 00000000
Feb 28 02:17:51 db2 kernel: ESR value after enabling vector: 00000000
Feb 28 02:17:51 db2 kernel: Calibrating delay loop... 3958.37 BogoMIPS
Feb 28 02:17:51 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 28 02:17:51 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 28 02:17:51 db2 kernel: CPU: L2 cache: 512K
Feb 28 02:17:51 db2 kernel: CPU: Physical Processor ID: 0
Feb 28 02:17:51 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: Intel machine check reporting enabled on
CPU#2.
Feb 28 02:17:51 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: CPU2: Intel(R) XEON(TM) CPU 2.00GHz stepping
04
Feb 28 02:17:51 db2 kernel: Booting processor 3/3 eip 2000
Feb 28 02:17:51 db2 kernel: Initializing CPU#3
Feb 28 02:17:51 db2 kernel: masked ExtINT on CPU#3
Feb 28 02:17:51 db2 kernel: ESR value before enabling vector: 00000000
Feb 28 02:17:51 db2 kernel: ESR value after enabling vector: 00000000
Feb 28 02:17:51 db2 kernel: Calibrating delay loop... 3958.37 BogoMIPS
Feb 28 02:17:51 db2 kernel: CPU: Before vendor init, caps: 3febfbff
00000000 00000000, vendor = 0
Feb 28 02:17:51 db2 kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Feb 28 02:17:51 db2 kernel: CPU: L2 cache: 512K
Feb 28 02:17:51 db2 kernel: CPU: Physical Processor ID: 3
Feb 28 02:17:51 db2 kernel: CPU: After vendor init, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: Intel machine check reporting enabled on
CPU#3.
Feb 28 02:17:51 db2 kernel: CPU:     After generic, caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: CPU:             Common caps: 3febfbff
00000000 00000000 00000000
Feb 28 02:17:51 db2 kernel: CPU3: Intel(R) XEON(TM) CPU 2.00GHz stepping
04
Feb 28 02:17:51 db2 kernel: Total of 4 processors activated (15833.49
BogoMIPS).
Feb 28 02:17:51 db2 kernel: cpu_sibling_map[0] = 2
Feb 28 02:17:51 db2 kernel: cpu_sibling_map[1] = 3
Feb 28 02:17:51 db2 kernel: cpu_sibling_map[2] = 0
Feb 28 02:17:51 db2 kernel: cpu_sibling_map[3] = 1
Feb 28 02:17:51 db2 kernel: ENABLING IO-APIC IRQs
Feb 28 02:17:51 db2 kernel: BIOS bug, IO-APIC#0 ID 2 is already used!...
Feb 28 02:17:51 db2 kernel: ... fixing up to 4. (tell your hw vendor)
Feb 28 02:17:51 db2 kernel: ...changing IO-APIC physical APIC ID to 4 ...
ok.
Feb 28 02:17:51 db2 kernel: init IO_APIC IRQs
Feb 28 02:17:51 db2 kernel:  IO-APIC (apicid-pin) 4-0, 4-10, 4-11, 4-15,
4-17, 4-18, 4-20, 4-21, 4-22 not connected.
Feb 28 02:17:51 db2 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Feb 28 02:17:51 db2 kernel: number of MP IRQ sources: 18.
Feb 28 02:17:51 db2 kernel: number of IO-APIC #4 registers: 24.
Feb 28 02:17:51 db2 kernel: testing the IO APIC.......................
Feb 28 02:17:51 db2 kernel:
Feb 28 02:17:51 db2 kernel: IO APIC #4......
Feb 28 02:17:51 db2 kernel: .... register #00: 04000000
Feb 28 02:17:51 db2 kernel: .......    : physical APIC id: 04
Feb 28 02:17:51 db2 kernel: .... register #01: 00178020
Feb 28 02:17:51 db2 kernel: .......     : max redirection entries: 0017
Feb 28 02:17:51 db2 kernel: .......     : PRQ implemented: 1
Feb 28 02:17:51 db2 kernel: .......     : IO APIC version: 0020
Feb 28 02:17:51 db2 kernel: .... register #02: 00000000
Feb 28 02:17:51 db2 kernel: .......     : arbitration: 00
Feb 28 02:17:51 db2 kernel: .... IRQ redirection table:
Feb 28 02:17:51 db2 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli
Vect:
Feb 28 02:17:51 db2 kernel:  00 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  01 00F 0F  0    0    0   0   0    1    1
39
Feb 28 02:17:51 db2 kernel:  02 00F 0F  0    0    0   0   0    1    1
31
Feb 28 02:17:51 db2 kernel:  03 00F 0F  0    0    0   0   0    1    1
41
Feb 28 02:17:51 db2 kernel:  04 00F 0F  0    0    0   0   0    1    1
49
Feb 28 02:17:51 db2 kernel:  05 00F 0F  0    0    0   0   0    1    1
51
Feb 28 02:17:51 db2 kernel:  06 00F 0F  0    0    0   0   0    1    1
59
Feb 28 02:17:51 db2 kernel:  07 00F 0F  0    0    0   0   0    1    1
61
Feb 28 02:17:51 db2 kernel:  08 00F 0F  0    0    0   0   0    1    1
69
Feb 28 02:17:51 db2 kernel:  09 00F 0F  0    0    0   0   0    1    1
71
Feb 28 02:17:51 db2 kernel:  0a 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  0b 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  0c 00F 0F  0    0    0   0   0    1    1
79
Feb 28 02:17:51 db2 kernel:  0d 00F 0F  0    0    0   0   0    1    1
81
Feb 28 02:17:51 db2 kernel:  0e 00F 0F  0    0    0   0   0    1    1
89
Feb 28 02:17:51 db2 kernel:  0f 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  10 00F 0F  1    1    0   1   0    1    1
91
Feb 28 02:17:51 db2 kernel:  11 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  12 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  13 00F 0F  1    1    0   1   0    1    1
99
Feb 28 02:17:51 db2 kernel:  14 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  15 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  16 000 00  1    0    0   0   0    0    0
00
Feb 28 02:17:51 db2 kernel:  17 00F 0F  1    1    0   1   0    1    1
A1
Feb 28 02:17:51 db2 kernel: IRQ to pin mappings:
Feb 28 02:17:51 db2 kernel: IRQ0 -> 0:2
Feb 28 02:17:51 db2 kernel: IRQ1 -> 0:1
Feb 28 02:17:51 db2 kernel: IRQ3 -> 0:3
Feb 28 02:17:51 db2 kernel: IRQ4 -> 0:4
Feb 28 02:17:51 db2 kernel: IRQ5 -> 0:5
Feb 28 02:17:51 db2 kernel: IRQ6 -> 0:6
Feb 28 02:17:51 db2 kernel: IRQ7 -> 0:7
Feb 28 02:17:51 db2 kernel: IRQ8 -> 0:8
Feb 28 02:17:51 db2 kernel: IRQ9 -> 0:9
Feb 28 02:17:51 db2 kernel: IRQ12 -> 0:12
Feb 28 02:17:51 db2 kernel: IRQ13 -> 0:13
Feb 28 02:17:51 db2 kernel: IRQ14 -> 0:14
Feb 28 02:17:51 db2 kernel: IRQ16 -> 0:16
Feb 28 02:17:51 db2 kernel: IRQ19 -> 0:19
Feb 28 02:17:51 db2 kernel: IRQ23 -> 0:23
Feb 28 02:17:51 db2 kernel: .................................... done.
Feb 28 02:17:51 db2 kernel: Using local APIC timer interrupts.
Feb 28 02:17:51 db2 kernel: calibrating APIC timer ...
Feb 28 02:17:51 db2 kernel: ..... CPU clock speed is 1982.5248 MHz.
Feb 28 02:17:51 db2 kernel: ..... host bus clock speed is 99.1260 MHz.
Feb 28 02:17:51 db2 kernel: cpu: 0, clocks: 991260, slice: 198252
Feb 28 02:17:51 db2 kernel:
CPU0<T0:991248,T1:792976,D:20,S:198252,C:991260>
Feb 28 02:17:51 db2 kernel: cpu: 2, clocks: 991260, slice: 198252
Feb 28 02:17:51 db2 kernel: cpu: 1, clocks: 991260, slice: 198252
Feb 28 02:17:51 db2 kernel: cpu: 3, clocks: 991260, slice: 198252
Feb 28 02:17:51 db2 kernel:
CPU1<T0:991248,T1:594736,D:8,S:198252,C:991260>
Feb 28 02:17:51 db2 kernel:
CPU2<T0:991248,T1:396480,D:12,S:198252,C:991260>
Feb 28 02:17:51 db2 kernel:
CPU3<T0:991248,T1:198240,D:0,S:198252,C:991260>
Feb 28 02:17:51 db2 kernel: checking TSC synchronization across CPUs:
passed.
Feb 28 02:17:51 db2 kernel: Waiting on wait_init_idle (map = 0xe)
Feb 28 02:17:51 db2 kernel: All processors have done init_idle
Feb 28 02:17:51 db2 kernel: mtrr: your CPUs had inconsistent fixed MTRR
settings
Feb 28 02:17:51 db2 kernel: mtrr: probably your BIOS does not setup all
CPUs
Feb 28 02:17:51 db2 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb3e0,
last bus=4
Feb 28 02:17:51 db2 kernel: PCI: Using configuration type 1
Feb 28 02:17:51 db2 kernel: PCI: Probing PCI hardware
Feb 28 02:17:51 db2 kernel: Unknown bridge resource 0: assuming
transparent
Feb 28 02:17:51 db2 kernel: Unknown bridge resource 1: assuming
transparent
Feb 28 02:17:51 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 28 02:17:51 db2 kernel: Unknown bridge resource 0: assuming
transparent
Feb 28 02:17:51 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 28 02:17:51 db2 kernel: Unknown bridge resource 0: assuming
transparent
Feb 28 02:17:52 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 28 02:17:52 db2 kernel: Unknown bridge resource 2: assuming
transparent
Feb 28 02:17:52 db2 kernel: PCI: Using IRQ router PIIX [8086/2440] at
00:1f.0
Feb 28 02:17:52 db2 kernel: PCI->APIC IRQ transform: (B0,I31,P1) -> 19
Feb 28 02:17:52 db2 kernel: PCI->APIC IRQ transform: (B4,I3,P0) -> 19
Feb 28 02:17:52 db2 kernel: PCI->APIC IRQ transform: (B4,I4,P0) -> 16
Feb 28 02:17:52 db2 kernel: Linux NET4.0 for Linux 2.4
Feb 28 02:17:52 db2 kernel: Based upon Swansea University Computer Society
NET3.039
Feb 28 02:17:52 db2 kernel: Initializing RT netlink socket
Feb 28 02:17:52 db2 kernel: Starting kswapd
Feb 28 02:17:52 db2 kernel: Real Time Clock Driver v1.10e
Feb 28 02:17:52 db2 kernel: block: 128 slots per queue, batch=32
Feb 28 02:17:52 db2 kernel: Uniform Multi-Platform E-IDE driver Revision:
6.31
Feb 28 02:17:52 db2 kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Feb 28 02:17:52 db2 kernel: PIIX4: IDE controller on PCI bus 00 dev f9
Feb 28 02:17:52 db2 kernel: PIIX4: chipset revision 4
Feb 28 02:17:52 db2 kernel: PIIX4: not 100%% native mode: will probe irqs
later
Feb 28 02:17:52 db2 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
settings: hda:DMA, hdb:pio
Feb 28 02:17:52 db2 kernel: hda: WDC WD1000JB-32CWE0, ATA DISK drive
Feb 28 02:17:52 db2 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 28 02:17:52 db2 kernel: hda: 195371568 sectors (100030 MB) w/8192KiB
Cache, CHS=12161/255/63, UDMA(100)
Feb 28 02:17:52 db2 kernel: Partition check:
Feb 28 02:17:52 db2 kernel:  hda: hda1 hda2 hda3 hda4
Feb 28 02:17:52 db2 kernel: Floppy drive(s): fd0 is 1.44M
Feb 28 02:17:52 db2 kernel: FDC 0 is a post-1991 82077
Feb 28 02:17:52 db2 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
Feb 28 02:17:52 db2 kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Feb 28 02:17:52 db2 kernel: eth0: OEM i82557/i82558 10/100 Ethernet,
00:30:48:21:B5:1A, IRQ 16.
Feb 28 02:17:52 db2 kernel:   Board assembly 000000-000, Physical
connectors present: RJ45
Feb 28 02:17:52 db2 kernel:   Primary interface chip i82555 PHY #1.
Feb 28 02:17:52 db2 kernel:   General self-test: passed.
Feb 28 02:17:52 db2 kernel:   Serial sub-system self-test: passed.
Feb 28 02:17:52 db2 kernel:   Internal registers self-test: passed.
Feb 28 02:17:52 db2 kernel:   ROM checksum self-test: passed (0x04f4518b).
Feb 28 02:17:52 db2 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 28 02:17:52 db2 kernel: IP Protocols: ICMP, UDP, TCP
Feb 28 02:17:52 db2 kernel: IP: routing cache hash table of 8192 buckets,
64Kbytes
Feb 28 02:17:52 db2 kernel: TCP: Hash tables configured (established
262144 bind 65536)
Feb 28 02:17:52 db2 kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Feb 28 02:17:52 db2 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Feb 28 02:17:52 db2 kernel: Freeing unused kernel memory: 212k freed
Feb 28 02:17:52 db2 kernel: Adding Swap: 104416k swap-space (priority -1)


