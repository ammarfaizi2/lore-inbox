Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273389AbTG3P2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273364AbTG3P23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:28:29 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:54154
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S273244AbTG3P1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:27:51 -0400
Date: Wed, 30 Jul 2003 11:43:26 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb and 2.6.0-test2
Message-ID: <20030730114326.B15543@animx.eu.org>
References: <89C0F2D0B58@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <89C0F2D0B58@vcnet.vc.cvut.cz>; from Petr Vandrovec on Tue, Jul 29, 2003 at 02:52:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Yes, it supports Millennium1 too. Are you sure that you built fbcon
> > > support into the kernel? And that you have only one fbdev, matroxfb?
> > 
> > Yes.  This caused a permenant black screen.  fbset did not give me anything
> > usable.  Monitor did not go into powersave.
> 
> I assume that machine is otherwise OK. Can you capture 'dmesg' from
> such boot and post them?

First: 2.6.0-test2 does not come up with a blank screen.
Second: using fbset to set another mode (1024x768-60) causes a blank screen
but changing vts gives me the screen back.  It must be using a different
frequency since the screen is not inthe same place.  setting 680x480-60
makes it look right again.  The actual resolution doesn't appear to change. 
If I have enough written to the screen after issueing the 1024x768, the text
becomes garbled (old text seems to interlace into current.

Any ideas?

Here's my .config (stripped, jsut console/fb stuff)
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
  where did this come from?!
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y

Here's the FULL dmesg (including modules I loaded later)
Linux version 2.6.0-test2 (root@kingkai) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Tue Jul 29 15:50:23 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 MSISYS                     ) @ 0x000f7290
ACPI: RSDT (v001 MSISYS MS-6163W 12336.11826) @ 0x0fff3000
ACPI: FADT (v001 MSISYS MS-6163W 12336.11826) @ 0x0fff3040
ACPI: DSDT (v001 MSISYS AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux ro root=301
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 701.809 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1388.54 BogoMIPS
Memory: 256432k/262080k available (1475k kernel code, 4920k reserved, 448k data, 108k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
matroxfb: Matrox Millennium (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x65536)
matroxfb: framebuffer at 0xE5000000, mapped to 0xd080d000, size 8388608
fb0: MATROX frame buffer device
fb0: initializing hardware
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
Asus Laptop ACPI Extras version 0.24a
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC AC34000L, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 7814016 sectors (4001 MB) w/256KiB Cache, CHS=7752/16/63
 hda: hda1 hda2 hda3 hda4
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 108k freed
EXT3 FS on hda1, internal journal
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Module md cannot be unloaded due to unsafe usage in include/linux/module.h:483
SCSI subsystem initialized
md: could not lock unknown-block(8,0).
md: could not import unknown-block(8,0)!
md: autostart unknown-block(8,0) failed!
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: PCI device 8086:7112
uhci-hcd 0000:00:07.2: irq 11, io base 0000e000
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
typhoon.c: version 1.5.1 (03/06/26)
eth0: 3Com Typhoon (3CR990SVR97) at 0xd1017000, 00:04:76:e0:9c:7b
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `nd' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
nfsd: last server has exited
nfsd: unexporting all filesystems
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 2
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 3
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
ppdev: user-space parallel port driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
ppdev0: registered pardevice
ppdev0: unregistered pardevice
lp0: using parport0 (polling).
ppdev0: registered pardevice
ppdev0: unregistered pardevice
ppdev0: registered pardevice
ppdev0: unregistered pardevice
usb 1-1: USB disconnect, address 3
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
