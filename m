Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266984AbUBMNMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266994AbUBMNMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:12:15 -0500
Received: from math.ut.ee ([193.40.5.125]:6809 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266984AbUBMNMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:12:03 -0500
Date: Fri, 13 Feb 2004 15:12:00 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange atkbd messages with missing keyboard
In-Reply-To: <20040212213613.GA417@ucw.cz>
Message-ID: <Pine.GSO.4.44.0402131509160.18344-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Meelis, can you please enable DEBUG in i8042.c, so that I can check
> where these unexpected NAKs come from?

Here is full dmesg (though probably only the serio and atkbd lines are
interesting).

Linux version 2.6.3-rc2 (mroos@rhn) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #2 Fri Feb 13 15:02:43 EET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28672 pages, LIFO batch:7
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=linux26 ro root=303 reboot=warm hdc=ide-scsi idebus=33
ide_setup: hdc=ide-scsi
ide_setup: idebus=33
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 200.493 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x34
Memory: 126808k/131072k available (1472k kernel code, 3700k reserved, 643k data, 112k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 395.26 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 008001bf 008005bf 00000000 00000000
CPU:     After vendor identify, caps: 008001bf 008005bf 00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After all inits, caps: 008001bf 008005bf 00000000 00000000
CPU: AMD-K6tm w/ multimedia extensions stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc1a0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc1c8, dseg 0xf0000
pnp: 00:09: ioport range 0x208-0x20f has been reserved
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16C PnP'
isapnp: 1 Plug & Play card detected total
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL ST1.6A, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA CD-ROM XM-6002B, ATAPI CD/DVD-ROM drive
hdd: ST32531A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 3153024 sectors (1614 MB) w/81KiB Cache, CHS=3128/16/63, UDMA(33)
 hda: hda1 hda2 hda3
hdd: max request size: 128KiB
hdd: 4996476 sectors (2558 MB), CHS=4956/16/63, DMA
 hdd: hdd1
mice: PS/2 mouse device common for all mice
input: PC Speaker
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [1]
drivers/input/serio/i8042.c: a5 <- i8042 (return) [1]
drivers/input/serio/i8042.c: a7 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 76 <- i8042 (return) [1]
drivers/input/serio/i8042.c: a8 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
drivers/input/serio/i8042.c: 56 <- i8042 (return) [1]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: 0f <- i8042 (return) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [2]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [2]
drivers/input/serio/i8042.c: a9 <- i8042 (return) [2]
drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: 5b <- i8042 (return) [3]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [3]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [3]
serio: i8042 AUX port at 0x60,0x64 irq 12
drivers/input/serio/i8042.c: 60 -> i8042 (command) [3]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [3]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [3]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [109]
drivers/input/serio/i8042.c: ed -> i8042 (parameter) [109]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [122]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [122]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [122]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [240]
atkbd.c: Unknown key pressed (raw set 0, code 0x17e on isa0060/serio1).
atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
drivers/input/serio/i8042.c: 60 -> i8042 (command) [241]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [241]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [241]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [241]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [294]
drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [294]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [360]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [360]
drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [360]
serio: i8042 KBD port at 0x60,0x64 irq 1
drivers/input/serio/i8042.c: 60 -> i8042 (command) [360]
drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [360]
drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [360]
drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [466]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, kbd, 1, timeout) [479]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [479]
drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [479]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, kbd, 1, timeout) [597]
atkbd.c: Unknown key released (translated set 0, code 0x7e on isa0060/serio0).
atkbd.c: Use 'setkeycodes 7e <keycode>' to make it known.
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding 66520k swap on /dev/hda2.  Priority:-1 extents:1
sb: Init: Starting Probe...
pnp: Device 01:01.00 activated.
sb: PnP: Found Card Named = "Creative ViBRA16C PnP", Card PnP id = CTL0070, Device PnP id = CTL0001
sb: PnP:      Detected at: io=0x220, irq=5, dma=1, dma16=5
SB 4.13 detected OK (220)
sb: Turning on MPU
sb: Init: Done
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #17 config 1000 status 782d advertising 01e1.
divert: allocating divert_blk for eth0
eth0: Digital DS21143 Tulip rev 65 at 0xc8822000, 00:48:54:12:83:3F, IRQ 10.
8139too Fast Ethernet driver 0.9.27
divert: allocating divert_blk for eth1
eth1: RealTek RTL8139 at 0xc8845000, 00:50:22:82:62:f0, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00006300
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usbnet
eth1: link up, 100Mbps, full-duplex, lpa 0x41E1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (1024 buckets, 8192 max) - 300 bytes per conntrack
eth0: Setting full-duplex based on MII#17 link partner capability of 45e1.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02e5c60(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth1: no IPv6 routers present
eth0: no IPv6 routers present
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, kbd, 0, timeout) [38647]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, kbd, 0, timeout) [38747]

-- 
Meelis Roos (mroos@linux.ee)

