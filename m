Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbUCNDYd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 22:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbUCNDYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 22:24:32 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:12116 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263257AbUCNDYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 22:24:22 -0500
Message-ID: <4053D064.9060905@blueyonder.co.uk>
Date: Sun, 14 Mar 2004 03:24:20 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bad: scheduling while atomic! 2.6.4-mm1 on x86 and x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2004 03:24:21.0156 (UTC) FILETIME=[D751AE40:01C40973]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On both Athlon x86 box and Athlon x86_64 laptop, I get errors during 
boot that are continuous, so I captured some on the x86 box via serial 
console.
^@Linux version 2.6.4-mm1 (root@barrabas) (gcc version 3.3.2 20031216 
(prerelease) (SuSE Linux)) #1 Thu
Mar 11 16:27:50 GMT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5c10
ACPI: RSDT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS A7V333   0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Built 1 zonelists
Found and enabled local APIC!
Initializing CPU#0
Kernel command line: root=/dev/hda1  vga=normal desktop splash=silent 
console=ttyS1
CPU 0 irqstacks, hard=c0476000 soft=c0475000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1802.998 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515096k/524272k available (2392k kernel code, 8428k reserved, 
928k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3547.13 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 2200+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1802.0010 MHz.
..... host bus clock speed is 266.0964 MHz.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf17e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040220
spurious 8259A interrupt: IRQ7.
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control 
Methods:............................................................................
.......................
Table [DSDT](id F004) - 275 Objects with 40 Devices 99 Methods 10 Regions
ACPI Namespace successfully loaded at root c048787c
ACPI: IRQ9 SCI: Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 
000000000000E420 on int 9
Completing Region/Field/Buffer/Package 
initialization:......................................
Initialized 10/10 Regions 0/0 Fields 17/17 Buffers 11/11 Packages (283 
nodes)
Executing all Device _STA and_INI 
methods:..........................................
42 Devices found containing: 42 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9a40
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9a70, dseg 0xf0000
pnp: 00:11: ioport range 0x290-0x297 has been reserved
pnp: 00:11: ioport range 0x3f0-0x3f1 has been reserved
pnp: 00:11: ioport range 0xe400-0xe47f has been reserved
pnp: 00:11: ioport range 0xec00-0xec3f has been reserved
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
 pci_irq-0302 [18] acpi_pci_irq_derive   : Unable to derive IRQ for 
device 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Simple Boot Flag 0x1
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 80x30
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
 pci_irq-0302 [19] acpi_pci_irq_derive   : Unable to derive IRQ for 
device 0000:00:11.1
ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y160P0, ATA DISK drive
hdb: ATAPI COMBO48XMAX, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, 
UDMA(133)
 hda: hda1 hda2
bad: scheduling while atomic!
Call Trace:
 [<c0118900>] schedule+0x600/0x650
 [<c01385c9>] find_get_pages_tag+0x89/0xa0
 [<c011897a>] preempt_schedule+0x2a/0x50
 [<c017ba27>] mpage_writepages+0x2f7/0x300
 [<c015f670>] blkdev_writepage+0x0/0x30
 [<c0210e97>] vsprintf+0x27/0x30
 [<c020dd7d>] kset_hotplug+0x25d/0x2a0
 [<c020dd7d>] kset_hotplug+0x25d/0x2a0
 [<c016097f>] generic_writepages+0x1f/0x23
 [<c013dd3e>] do_writepages+0x1e/0x40
 [<c0137c68>] __filemap_fdatawrite+0x98/0xb0
 [<c0137c97>] filemap_fdatawrite+0x17/0x20
 [<c01590a6>] sync_blockdev+0x26/0x50
 [<c01605aa>] blkdev_put+0xea/0x1e0
 [<c027b327>] add_disk+0x47/0x60
 [<c027b2b0>] exact_match+0x0/0x10
 [<c027b2c0>] exact_lock+0x0/0x20
 [<c02a037a>] idedisk_attach+0x11a/0x1b0
 [<c0290234>] ata_attach+0x144/0x1d0
 [<c02911ae>] ide_register_driver+0xde/0x130
 [<c02a041f>] idedisk_init+0xf/0x20
 [<c0442823>] do_initcalls+0x23/0xc0
 [<c012ce9f>] init_workqueues+0xf/0x30
 [<c01030a0>] init+0x0/0x160
 [<c01030d5>] init+0x35/0x160
 [<c0106a40>] kernel_thread_helper+0x0/0x10
 [<c0106a45>] kernel_thread_helper+0x5/0x10

error in initcall at 0xc02a0410: returned with preemption imbalance
hdb: ATAPI 40X DVD-ROM CD-R/RW CD-MRW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 11
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
bad: scheduling while atomic!
bad: scheduling while atomic!
Call Trace:
 [<c0118900>] schedule+0x600/0x650
 [<c010a836>] do_IRQ+0x186/0x1f0
 [<c0355f45>] need_resched+0x27/0x32
 [<c026d5d0>] serial_in+0x20/0x40
 [<c02701e0>] serial8250_conr+0x0/0x650
<4> [<c015f09e>] do_kern_mount+0xae/0x180
 [<c01767ba>] do_add_mount+0x6a/0x150
 [<c0176b62>] do_mount+0x1b2/0x1f0
 [<c017692c>] copy_mount_options+0x8c/0x110
 [<c0176f7f>] sys_mount+0xbf/0x140
 [<c0442f9f>] do_mount_root+0x2f/0xa0
 [<c0443070>] mount_block_root+0x60/0x140
 [<c0443372>] mount_root+0x72/0xf0
 [<c044343d>] prepare_namespace+0x4d/0x120
 [<c01030a0>] init+0x0/0x160
 [<c01030a0>] init+0x0/0x160
 [<c01031b6>] init+0x116/0x160
 [<c0106a40>] kernel_thread_helper+0x0/0x10
 [<c0106a45>] kernel_thread_helper+0x5/0x10

bad: scheduling while atomic!
Call Trace:
 [<c0118900>] schedule+0x600/0x650
 [<c010a836>] do_IRQ+0x186/0x1f0
 [<c0355f45>] need_resched+0x27/0x32
 [<c026d5d0>] serial_in+0x20/0x40
 [<c02701e0>] serial8250_console_write+0x80/0x280
 [<c0_super+0x0/0x650
<4> [<c015f09e>] do_kern_mount+0xae/0x180
 [<c01767ba>] do_add_mount+0x6a/0x150
<SNIPPED>
Recompiling x86_64 without preemption to see if that works.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

