Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTI1Kn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTI1Kn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:43:28 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:63691 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262359AbTI1KnV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:43:21 -0400
Date: Sun, 28 Sep 2003 12:43:12 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: HT not working by default since 2.4.22
Message-ID: <20030928104312.GA9770@louise.pinerecords.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC870C@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC870C@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmm, I happen to know of a system that fails to detect the 
> > sibling CPU(s) with CONFIG_ACPI_HT_ONLY set, whereas w/o it
> > "all fine running's."
> > 
> > Is this a bug?
> 
> Yes, could you file it on bugzilla.org Power management/acpi?

It seems 2.4.23-pre5 can't enable the sibling CPU even with
full ACPI enabled on this system...  .config attached,
relevant parts of dmesg follow:

(The kernels I was talking about previously were 2.4.22-ac*.)

Compaq ProLiant ML350 G3 detected: force use of acpi=ht
ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f4f70
ACPI: RSDT (v001 COMPAQ D14      0x00000002 Ò 0x0000162e) @ 0x2fffa000
ACPI: FADT (v001 COMPAQ D14      0x00000002 Ò 0x0000162e) @ 0x2fffa040
ACPI: MADT (v001 COMPAQ 00000083 0x00000002 Ò 0x0000162e) @ 0x2fffa100
ACPI: SPCR (v001 COMPAQ SPCRRBSU 0x00000001 Ò 0x0000162e) @ 0x2fffa1c0
ACPI: DSDT (v001 COMPAQ     DSDT 0x00000001 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] disabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] polarity[0x0] trigger[0x0] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
I/O APIC #4 Version 17 at 0xFEC02000.
I/O APIC #5 Version 17 at 0xFEC03000.
Enabling APIC mode: Flat.	Using 4 I/O APICs
Processors: 2
Kernel command line: root=/dev/md0 rw vga=normal
Initializing CPU#0
Detected 1993.588 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 774560k/786408k available (1819k kernel code, 11460k reserved, 436k data, 288k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.00GHz stepping 07
per-CPU timeslice cutoff: 1462.63 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
WARNING: No sibling found for CPU 0.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 5-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  1    1    0   1   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  1    1    0   1   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 04000000
.......     : arbitration: 04
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 05000000
.......     : arbitration: 05
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1993.4372 MHz.
..... host bus clock speed is 99.6718 MHz.
cpu: 0, clocks: 996718, slice: 498359
CPU0<T0:996704,T1:498336,D:9,S:498359,C:996718>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
ACPI: Subsystem revision 20030916
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
PCI: Device 00:00 not found by BIOS
PCI: Device 00:01 not found by BIOS
PCI: Device 00:02 not found by BIOS
PCI: Device 00:78 not found by BIOS
PCI: Device 00:7b not found by BIOS
PCI: Device 00:88 not found by BIOS
PCI: Device 00:8a not found by BIOS
Linux NET4.0 for Linux 2.4
...

-- 
Tomas Szepe <szepe@pinerecords.com>
