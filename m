Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUBTSDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUBTSDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:03:46 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:9131 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S261358AbUBTSDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:03:16 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.6.3 : [eth0: Too much work at interrupt, status=0x00000001.]
Date: Fri, 20 Feb 2004 18:03:11 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402201803.12146.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting loads of these messages in dmesg.

This is a vanilla 2.6.3 kernel with ACPI disabled with acpi=off boot 
parameter. No preempt, APIC and IOAPIC enabled

Its a single 2Ghz celeron with Via chipset and Rhine II ethernet. It is under 
no load at all. ssh only.

dmesg is short and follows; Any knowledge apprieciated!

Linux version 2.6.3 (linux@p15149774.pureserver.info) (gcc version 3.3.3) #1 
Fri Feb 20 08:51:28 GMT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
 BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000000f7f0000 (usable)
247MB LOWMEM available.
found SMP MP-table at 000f4ed0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 63472
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59376 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 15:2 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=/dev/hda2 acpi=off mem=253888K
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2003.764 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 248132k/253888k available (1554k kernel code, 5016k reserved, 483k 
data, 312k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3940.35 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
CPU: Intel(R) Celeron(R) CPU 2.00GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  1    1    0   1   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    B1
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
IRQ16 -> 0:16
IRQ23 -> 0:23
IRQ31 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2003.0089 MHz.
..... host bus clock speed is 100.0154 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb300, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3177] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I17,P0) -> 31
PCI->APIC IRQ transform: (B0,I18,P0) -> 23
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
ikconfig 0.7 with /proc/config*
PCI: Via IRQ fixup for 0000:00:10.1, from 255 to 0
PCI: Via IRQ fixup for 0000:00:10.2, from 255 to 0
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xe000, 00:40:63:c7:f6:8e, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
hda: ST340014A, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 312k freed
EXT3 FS on hda2, internal journal
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda4, size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda4) for (hda4)
Using r5 hash to sort names
Adding 987988k swap on /dev/hda3.  Priority:-1 extents:1
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.
eth0: Too much work at interrupt, status=0x00000001.

