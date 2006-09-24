Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWIXWK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWIXWK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWIXWK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:10:26 -0400
Received: from wmail-1.airmail.net ([209.196.70.86]:50370 "EHLO
	wmail-1.airmail.net") by vger.kernel.org with ESMTP
	id S1751178AbWIXWKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:10:24 -0400
From: "Art Haas" <ahaas@airmail.net>
Date: Sun, 24 Sep 2006 17:10:20 -0500
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Subject: CDROM drive not found when booting using new libata code
Message-ID: <20060924221020.GB2080@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

As Linus has just pulled in the large libata changes into his tree, I
wanted to try out the new code. I'm running Debian on a PIIX
motherboard, and I've enclosed the 'dmesg' output for the machine
when booting 2.6.18 which uses the piix.c code in drivers/ide and
the new 2.6.18+ code which uses ata_piix.c in drivers/ata.

Here's the drivers/ide dmesg output:

Linux version 2.6.18 (arth@pcdebian) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #1 Wed Sep 20 06:56:45 CDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 28656 pages, LIFO batch:7
DMI 2.1 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6c60
ACPI: RSDT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x07ff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x07ff3040
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x01000007) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 10000000 (gap: 08000000:f7ff0000)
Detected 398.944 MHz processor.
Built 1 zonelists.  Total pages: 32752
Kernel command line: BOOT_IMAGE=linux-2.6.18 ro root=301
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 127296k/131008k available (1395k kernel code, 3248k reserved, 437k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 798.25 BogoMIPS (lpj=399125)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 4000-403f claimed by PIIX4 ACPI
PCI quirk: region 5000-500f claimed by PIIX4 SMB
Boot video device is 0000:00:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: ST33232A, ATA DISK drive
hdb: FUJITSU MPD3084AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=6253/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63, UDMA(33)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 < hdb5 hdb6 > hdb3
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 132k freed
input: AT Translated Set 2 keyboard as /class/input/input0
NET: Registered protocol family 1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
hdc: ATAPI 24X CD-ROM drive, 120kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL8139 at 0xc8818000, 00:05:5d:45:47:96, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
Real Time Clock Driver v1.12ac
Adding 100760k swap on /dev/hda7.  Priority:-1 extents:1 across:100760k
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 17
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ttyS3: LSR safety check engaged!
ttyS3: LSR safety check engaged!
EXT3 FS on hda5, internal journal
EXT3 FS on hda6, internal journal
EXT3 FS on hdb5, internal journal
EXT3 FS on hdb6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 100760k swap on /dev/hda7.  Priority:-2 extents:1 across:100760k

Now, here's the dmesg output for the drivers/ata code:

Linux version 2.6.18-pata (arth@pcdebian) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #3 Sun Sep 24 15:35:31 CDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 28656 pages, LIFO batch:7
DMI 2.1 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6c60
ACPI: RSDT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x07ff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x00000000  0x00000000) @ 0x07ff3040
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x01000007) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 10000000 (gap: 08000000:f7ff0000)
Detected 398.971 MHz processor.
Built 1 zonelists.  Total pages: 32752
Kernel command line: BOOT_IMAGE=2.6.18-pata ro root=301 root=/dev/sda1
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 127264k/131008k available (1445k kernel code, 3280k reserved, 453k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 798.27 BogoMIPS (lpj=399137)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
* Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
* this clock source is slow. Consider trying other clock sources
PCI quirk: region 4000-403f claimed by PIIX4 ACPI
PCI quirk: region 5000-500f claimed by PIIX4 SMB
Boot video device is 0000:00:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0A03
pnp: ACPI device : hid PNP0C01
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0400
pnp: ACPI device : hid PNP0303
pnp: PnP ACPI: found 12 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:02' and the driver 'system'
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:09' and the driver 'serial'
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
libata version 2.00 loaded.
ata_piix 0000:00:07.1: version 2.00ac6
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
ata1.00: ATA-2, max UDMA/33, 6303024 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-4, max UDMA/66, 16514064 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
scsi1 : ata_piix
ATA: abnormal status 0xFF on port 0x177
ATA: abnormal status 0xFF on port 0x177
ata2.00: ATAPI, max MWDMA1
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to PIO4
ata2: failed to recover some devices, retrying in 5 secs
ATA: abnormal status 0xFF on port 0x177
ATA: abnormal status 0xFF on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to PIO0
ata2: failed to recover some devices, retrying in 5 secs
ATA: abnormal status 0xFF on port 0x177
ATA: abnormal status 0xFF on port 0x177
ata2.00: qc timeout (cmd 0xa1)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
scsi 0:0:0:0: Direct access     ATA      ST33232A         3.02 PQ: 0 ANSI: 5
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write through
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: Direct access     ATA      FUJITSU MPD3084A DD-0 PQ: 0 ANSI: 5
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 > sdb3
sd 0:0:1:0: Attached scsi disk sdb
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 136k freed
input: AT Translated Set 2 keyboard as /class/input/input0
NET: Registered protocol family 1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Real Time Clock Driver v1.12ac
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
eth0: RealTek RTL8139 at 0xc8824000, 00:05:5d:45:47:96, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
Adding 100760k swap on /dev/sda7.  Priority:-1 extents:1 across:100760k
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 17
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ttyS3: LSR safety check engaged!
ttyS3: LSR safety check engaged!
EXT3 FS on sda5, internal journal
EXT3 FS on sda6, internal journal
EXT3 FS on sdb5, internal journal
EXT3 FS on sdb6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

The new kernel has PnP debug messages enabled as I'm also trying to
figure out why my TurtleBeach Mailbu soundcard is often not found
by the isapnp system, but that is a minor inconvenience. Another
problem I haven't figured out is the 'LSR safety check engaged'
message, but again it doesn't seem to affect things.

Kernel configuration info can be provided if deemed helpful, and
I'll gladly try out patches to get the problem resolved.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
