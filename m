Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWIMKVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWIMKVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 06:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWIMKVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 06:21:41 -0400
Received: from mx.laposte.net ([81.255.54.11]:41808 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1751429AbWIMKVk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 06:21:40 -0400
Date: Wed, 13 Sep 2006 12:21:37 +0200
Message-Id: <J5J0S1$E84BD2336C01F896088E954AAF120859@laposte.net>
Subject: (Another?) Seagate / Sil3112a problem...
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "philippe\.grenard" <philippe.grenard@laposte.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B103)
X-SenderIP: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Before anything, i'm not on the list, so could you please cc
me if you've got any piece of advice for my problem?

So, here are the facts...

My hardware is an Asus A7N8X-Deluxe rev2.0 Motherboard with
the latest Bios from asus (1008 I believe)
Last month, after a crash from a very old PATA drive, i
decided to purchase a new SATA drive. So I bought a 250 Go
Seagate 7200.8 drive. 
Well, all went well for a week or two, but then the drive
began to make strange noises, and i got some weird messages
from dmesg output...
I feared a drive failure, so I made a full Seagate diagnoses
of the disk, but no errors...
Well, maybe I got bad luck with that drive, so I decided to
get another one. I took another Seagate, 250Go, 7200.10 this time.

I put this new Seagate (let's call it S_new, the other being
S_old) to the first connector of the Sil 3112a chip, and put
the "old" one on the second connector : thus I have sda for
S_new, and sdb for S_old...

What is really surprising, is that i still got issues with
sda, but none with sdb... so the believed faulty drive is not,
as i got no dmesg errors from sdb...

thus i suspect either a faulty controller, or a problem with
the driver (sata_sil) i use...(or even something with IRQ as I
don't understand anything with IRQ...)
I tried to put both disks numbers in the "blacklist" in
sata_sil.c, but apart from a degraded speed, it didn't do
anything...

The other observation I made, was that these problems happens
only when the computer is still "cold" : I mean, after an hour
or two, no problem with this... and even if i reboot (I really
mean reboot, not halt and restart : when the power still turns
on), i got no problem...

Well since I use my computer for Desktop, it really is an
issue for me at the moment, especially when the disk is making
a noise...

I'm on Linux for about 2 or 3 years now, under Debian/SID,
with kernel 2.6.17.13 from kernel.org (self-compiled)

Here is the output of dmesg if it helps...
I can provide any information you would find useful, even make
some tests, but if you could be not too technical, that would
really be great, as I'm a real noob with Hardware problems...

Any help/links/infos/hints would really be appreciated!
I've already googled a lot and found that Seagate/sil3112a is
a problematic couple, but i didn't find any solution for that...
I'll try this evening with an older kernel (if you have any
suggestion for a kernel version...) to see if it's not related
to a kernel upgrade...

thanks to all for your patience...and sorry for my approximate
english...

Philippe

--------------------------------------------

T: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=3
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:03:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it
helps, post a report
PCI: Bridge: 0000:00:08.0
  IO window: a000-bfff
  MEM window: e5000000-e6ffffff
  PREFETCH window: 70000000-700fffff
PCI: Bridge: 0000:00:0c.0
  IO window: c000-cfff
  MEM window: e0000000-e1ffffff
  PREFETCH window: 70100000-701fffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: e2000000-e4ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:08.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576
bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using
5120k, total 
262144k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:c6c0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] Initialized drm 1.0.1 20051102
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling
workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD800BB-00CAA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PIONEER DVD-RW DVR-107D, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48125S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache,
CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 > hda4
libata version 1.20 loaded.
sata_sil 0000:01:0b.0: version 0.9
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNK3] -> GSI 11
(level, low) -> 
IRQ 11
ata1: SATA max UDMA/100 cmd 0xF8822080 ctl 0xF882208A bmdma
0xF8822000 irq 11
ata2: SATA max UDMA/100 cmd 0xF88220C0 ctl 0xF88220CA bmdma
0xF8822008 irq 11
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469
86:3c01 87:4023 
88:207f
ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata1(0): applying Seagate errata fix (mod15write workaround)
ata1(0): applying Seagate errata fix (mod15write workaround)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469
86:3c01 87:4023 
88:207f
ata2: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata2(0): applying Seagate errata fix (mod15write workaround)
ata2(0): applying Seagate errata fix (mod15write workaround)
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: ST3250620AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI
revision: 05
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI
revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
usbmon: debugfs is not available
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUB2] -> GSI 10
(level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus
number 1
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: irq 10, io mem 0xe7083000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10
Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI)
Driver (PCI)
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUBA] -> GSI 10
(level, low) -> 
IRQ 10
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus
number 2
ohci_hcd 0000:00:02.0: irq 10, io mem 0xe7087000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUBB] -> GSI 5
(level, low) -> 
IRQ 5
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus
number 3
ohci_hcd 0000:00:02.1: irq 5, io mem 0xe7082000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
USB Universal Host Controller Interface driver v3.0
usb 3-1: new low speed USB device using ohci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-2: new full speed USB device using ohci_hcd and address 3
usb 3-2: configuration #1 chosen from 1 choice
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-2.1: new low speed USB device using ohci_hcd and address 4
usb 3-2.1: configuration #1 chosen from 1 choice
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 116k freed
input: AT Translated Set 2 keyboard as /class/input/input0
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) 
as /class/input/input1
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse
with 
IntelliEye(TM)] on usb-0000:00:02.1-1
ACPI: PCI Interrupt Link [L3CM] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [L3CM] -> GSI 10
(level, low) -> 
IRQ 10
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:01.0: 3Com PCI 3c920 Tornado at f8836000.
forcedeth.c: Reverse Engineered nForce ethernet driver.
Version 0.54.
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LMAC] -> GSI 5
(level, low) -> 
IRQ 5
PCI: Setting latency timer of device 0000:00:04.0 to 64
input: Microsoft Internet Keyboard Pro as /class/input/input2
input: USB HID v1.10 Keyboard [Microsoft Internet Keyboard
Pro] on 
usb-0000:00:02.1-2.1
input: Microsoft Internet Keyboard Pro as /class/input/input3
input: USB HID v1.10 Device [Microsoft Internet Keyboard Pro] on 
usb-0000:00:02.1-2.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
eth0: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 3
(level, low) -> 
IRQ 3
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 50741 usecs
intel8x0: clocking to 47446
EXT3 FS on hda7, internal journal
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNK4] -> GSI 7
(level, low) -> 
IRQ 7
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-8774  Tue
Aug  1 20:54:08 
PDT 2006
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [L3CM] -> GSI 10
(level, low) -> 
IRQ 10
eth1:  setting half-duplex.
ip_tables: (C) 2000-2006 Netfilter Core Team
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 204 bytes
per conntrack
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
lp: driver loaded but no devices found
i2c_adapter i2c-2: SMBus Quick command not supported, can't
probe for chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't
probe for chips
i2c_adapter i2c-4: SMBus Quick command not supported, can't
probe for chips
ata1: command 0xc8 timeout, stat 0xd0 host_stat 0x1
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
    ASC=0x47 ASCQ=0x0
Info fld=0x41
end_request: I/O error, dev sda, sector 65
EXT3-fs: unable to read superblock
ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }
ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
0xb/47/00
ata1: status=0xd0 { Busy }

Accédez au courrier électronique de La Poste 
sur www.laposte.net ou sur 3615 LAPOSTENET (0,34€ TTC /mn) 
1 Giga de stockage gratuit – Antispam et antivirus intégrés 



