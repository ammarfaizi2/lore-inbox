Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTI2G4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 02:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTI2G4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 02:56:54 -0400
Received: from math.ut.ee ([193.40.5.125]:40595 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262782AbTI2G4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 02:56:45 -0400
Date: Mon, 29 Sep 2003 09:56:43 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: irq 12: nobody cared! (2.6.0-test6)
Message-ID: <Pine.GSO.4.44.0309290947230.9442-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Linux 2.6.0-test6 on a PC with VIA KT133A chipset (MSI MS-6330
mainboard), PS/2 keyboard, USB mouse. In test5 it hung on boot just
after printing
mice: PS/2 mouse device common for all mice
input: PC Speaker

In 2.6.0-test6, it spits out several "irq 12: nobody cared!" messages
with backtraces and then continues as if nothing happened. The system
works fine, PS/2 keyboard and USB mouse both work too. Similar
configuration (PS/2 keyboard + USB mouse) works fine on an i815 chipset
computer.

Linux version 2.6.0-test6 (mroos@vaarikas) (gcc version 3.3.2 20030908 (Debian prerelease)) #15 Sun Sep 28 13:06:21 EEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
 BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98288
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94192 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f80c0
ACPI: RSDT (v001 VIA694 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x17ff3000
ACPI: FADT (v001 VIA694 MSI ACPI 0x42302e31 AWRD 0x00000000) @ 0x17ff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux2.6 ro root=301
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1299.326 MHz processor.
Console: colour VGA+ 80x25
Memory: 385556k/393152k available (1714k kernel code, 6844k reserved, 755k data, 156k init, 0k highmem)
Calibrating delay loop... 2555.90 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1299.0155 MHz.
..... host bus clock speed is 199.0870 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb590, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc060
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc090, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
divert: not allocating divert_blk for non-ethernet device lo
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:07.2, from 12 to 5
PCI: Via IRQ fixup for 0000:00:07.3, from 12 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340014A, ATA DISK drive
hdb: WDC WD1200JB-75CRA0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: Host Protected Area detected.
	current capacity is 234375000 sectors (120000 MB)
	native  capacity is 234441648 sectors (120034 MB)
hdb: Host Protected Area disabled.
hdb: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3
mice: PS/2 mouse device common for all mice
input: PC Speaker
irq 12: nobody cared!
Call Trace:
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+108/160] note_interrupt+0x6c/0xa0
 [do_IRQ+222/224] do_IRQ+0xde/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [do_softirq+64/160] do_softirq+0x40/0xa0
 [do_IRQ+197/224] do_IRQ+0xc5/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [setup_irq+110/176] setup_irq+0x6e/0xb0
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [request_irq+131/208] request_irq+0x83/0xd0
 [i8042_check_mux+61/368] i8042_check_mux+0x3d/0x170
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [i8042_init+282/336] i8042_init+0x11a/0x150
 [do_initcalls+43/160] do_initcalls+0x2b/0xa0
 [init_workqueues+15/96] init_workqueues+0xf/0x60
 [init+41/272] init+0x29/0x110
 [init+0/272] init+0x0/0x110
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

handlers:
[i8042_interrupt+0/368] (i8042_interrupt+0x0/0x170)
Disabling IRQ #12
irq 12: nobody cared!
Call Trace:
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+108/160] note_interrupt+0x6c/0xa0
 [do_IRQ+222/224] do_IRQ+0xde/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [do_softirq+64/160] do_softirq+0x40/0xa0
 [do_IRQ+197/224] do_IRQ+0xc5/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [setup_irq+110/176] setup_irq+0x6e/0xb0
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [request_irq+131/208] request_irq+0x83/0xd0
 [i8042_check_aux+50/336] i8042_check_aux+0x32/0x150
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [i8042_init+241/336] i8042_init+0xf1/0x150
 [do_initcalls+43/160] do_initcalls+0x2b/0xa0
 [init_workqueues+15/96] init_workqueues+0xf/0x60
 [init+41/272] init+0x29/0x110
 [init+0/272] init+0x0/0x110
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

handlers:
[i8042_interrupt+0/368] (i8042_interrupt+0x0/0x170)
Disabling IRQ #12
irq 12: nobody cared!
Call Trace:
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+108/160] note_interrupt+0x6c/0xa0
 [do_IRQ+222/224] do_IRQ+0xde/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [do_softirq+64/160] do_softirq+0x40/0xa0
 [do_IRQ+197/224] do_IRQ+0xc5/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [setup_irq+110/176] setup_irq+0x6e/0xb0
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [request_irq+131/208] request_irq+0x83/0xd0
 [i8042_open+104/256] i8042_open+0x68/0x100
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [serio_open+24/64] serio_open+0x18/0x40
 [atkbd_connect+286/816] atkbd_connect+0x11e/0x330
 [serio_find_dev+106/128] serio_find_dev+0x6a/0x80
 [serio_register_port+64/96] serio_register_port+0x40/0x60
 [i8042_port_register+63/144] i8042_port_register+0x3f/0x90
 [i8042_init+265/336] i8042_init+0x109/0x150
 [do_initcalls+43/160] do_initcalls+0x2b/0xa0
 [init_workqueues+15/96] init_workqueues+0xf/0x60
 [init+41/272] init+0x29/0x110
 [init+0/272] init+0x0/0x110
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

handlers:
[i8042_interrupt+0/368] (i8042_interrupt+0x0/0x170)
Disabling IRQ #12
irq 12: nobody cared!
Call Trace:
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+108/160] note_interrupt+0x6c/0xa0
 [do_IRQ+222/224] do_IRQ+0xde/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [do_softirq+64/160] do_softirq+0x40/0xa0
 [do_IRQ+197/224] do_IRQ+0xc5/0xe0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [setup_irq+110/176] setup_irq+0x6e/0xb0
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [request_irq+131/208] request_irq+0x83/0xd0
 [i8042_open+104/256] i8042_open+0x68/0x100
 [i8042_interrupt+0/368] i8042_interrupt+0x0/0x170
 [serio_open+24/64] serio_open+0x18/0x40
 [psmouse_connect+204/544] psmouse_connect+0xcc/0x220
 [serio_find_dev+106/128] serio_find_dev+0x6a/0x80
 [serio_register_port+64/96] serio_register_port+0x40/0x60
 [i8042_port_register+63/144] i8042_port_register+0x3f/0x90
 [i8042_init+265/336] i8042_init+0x109/0x150
 [do_initcalls+43/160] do_initcalls+0x2b/0xa0
 [init_workqueues+15/96] init_workqueues+0xf/0x60
 [init+41/272] init+0x29/0x110
 [init+0/272] init+0x0/0x110
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

handlers:
[i8042_interrupt+0/368] (i8042_interrupt+0x0/0x170)
Disabling IRQ #12
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 167751
ext3_orphan_cleanup: deleting unreferenced inode 167749
ext3_orphan_cleanup: deleting unreferenced inode 167747
ext3_orphan_cleanup: deleting unreferenced inode 167745
ext3_orphan_cleanup: deleting unreferenced inode 165226
ext3_orphan_cleanup: deleting unreferenced inode 165153
ext3_orphan_cleanup: deleting unreferenced inode 164897
ext3_orphan_cleanup: deleting unreferenced inode 164278
ext3_orphan_cleanup: deleting unreferenced inode 163872
EXT3-fs: hda1: 9 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k freed
...

-- 
Meelis Roos (mroos@linux.ee)

