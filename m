Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUGYQ2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUGYQ2U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 12:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUGYQ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 12:28:20 -0400
Received: from mail.gmx.de ([213.165.64.20]:12469 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264192AbUGYQ2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 12:28:10 -0400
X-Authenticated: #1489797
From: Nesimi Buelbuel <nesimi.buelbuel@gmx.de>
Subject: Re: High CPU usage for disk I/O while DMA is enabled
Date: Sun, 25 Jul 2004 18:28:07 +0200
References: <2lP3i-3pV-13@gated-at.bofh.it> <2lSDW-5Ln-13@gated-at.bofh.it> <2lT6Y-69m-27@gated-at.bofh.it> <2lTqe-6jZ-9@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <S264192AbUGYQ2K/20040725162810Z+1044@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Pereira <gotrooted@pop.com.br> wrote:

> What is your motherboard ???
> You must enable in .config the right IDE busmaster for your mobo.

It is a K7S5A Pro with a SiS 735 Chipset.
I have set the option for my motherboard, otherwise I couldnt even start
my system.

CONFIG_BLK_DEV_SIS5513=y

The configuration of the Kernel is nearly the same in the 2.6.7
as it was in my old 2.4.26 Kernel, where everything runs fine.

<snip>
gasmaske:~# lspci 
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP)
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
0000:00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07)
0000:00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 07)
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
0000:00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 90)
0000:00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
0000:00:0f.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 43)
0000:00:13.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50)
0000:00:13.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50)
0000:00:13.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)

gasmaske:~# dmesg
Linux version 2.6.7 (root@gasmaske) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #8 Wed Jul 21 20:31:03 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa340
ACPI: RSDT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 0x1fff0000
ACPI: FADT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 0x1fff0030
ACPI: DSDT (v001    SiS      735 0x00000100 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=302
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1394.318 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515140k/524224k available (2542k kernel code, 8320k reserved, 990k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2760.70 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1c3f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Uncovering SIS18 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
PCI: Using IRQ router SIS [1039/0018] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:02.1
PCI: Sharing IRQ 11 with 0000:00:13.1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 735 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd0000000
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
lp0: console ready
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
PCI: Found IRQ 12 for device 0000:00:0f.0
PCI: Sharing IRQ 12 with 0000:00:02.2
eth0: VIA VT6102 Rhine-II at 0xcc00, 00:50:ba:12:7f:25, IRQ 12.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y160P0, ATA DISK drive
hdb: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC35L080AVVA07-0, ATA DISK drive
hdd: Maxtor 6Y080L0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(33)
 hda: hda1 hda2 hda3
hdc: max request size: 128KiB
hdc: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(33)
 hdc: hdc1
hdd: max request size: 128KiB
hdd: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
 hdd: hdd1 < >
hdb: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 5 for device 0000:00:13.2
PCI: Sharing IRQ 5 with 0000:00:02.7
PCI: Sharing IRQ 5 with 0000:00:0d.0
ehci_hcd 0000:00:13.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:13.2: irq 5, pci mem e087de00
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Found IRQ 12 for device 0000:00:02.2
PCI: Sharing IRQ 12 with 0000:00:0f.0
ohci_hcd 0000:00:02.2: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:02.2: irq 12, pci mem e087f000
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
PCI: Found IRQ 12 for device 0000:00:02.3
ohci_hcd 0000:00:02.3: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:02.3: irq 12, pci mem e0881000
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:13.0
uhci_hcd 0000:00:13.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:13.0: irq 11, io base 0000c400
uhci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:13.1
PCI: Sharing IRQ 11 with 0000:00:02.1
uhci_hcd 0000:00:13.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:13.1: irq 11, io base 0000c800
uhci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
PCI: Found IRQ 5 for device 0000:00:0d.0
PCI: Sharing IRQ 5 with 0000:00:02.7
PCI: Sharing IRQ 5 with 0000:00:13.2
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xd000, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
usb 4-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:13.0-1
Adding 586332k swap on /dev/hda1.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
[...]
</snip>

Any hints appreciatet :)

