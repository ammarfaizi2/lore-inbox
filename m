Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268341AbSIRUj0>; Wed, 18 Sep 2002 16:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268344AbSIRUj0>; Wed, 18 Sep 2002 16:39:26 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:16098 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268341AbSIRUjW>; Wed, 18 Sep 2002 16:39:22 -0400
Subject: BUG: Current 2.5-BK tree dies on boot!
To: linux-kernel@vger.kernel.org (Linux Kernel)
Date: Wed, 18 Sep 2002 21:44:25 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is without preempt. I tried both with and without SMP, with and without
large TLB pages, with and without pte highmem, all die in the same place.

Here are the boot messages:

Linux version 2.5.36 (aia21@drop.stormcorp.org) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #11 SMP Thu Sep 12 21:11:41 BST 2002
Video mode to be used for restore is f06
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages
  Normal zone: 225280 pages
  HighMem zone: 32752 pages
ACPI: RSDP (v000 VIA694                     ) @ 0x000f79f0
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3040
Kernel command line: BOOT_IMAGE=l2536 ro root=301 console=ttyS1,115200n8 console=tty0 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1336.509 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 2629.63 BogoMIPS
Memory: 1033160k/1048512k available (2040k kernel code, 14968k reserved, 1230k data, 88k init, 131008k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020829
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
usb.c: registered new driver usbfs
usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi'
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 44
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Applying VIA southbridge workaround.
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xc0000000 256MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
block: 256 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c905C Tornado at 0xe800. Vers LK1.1.18
phy=0, phyx=24, mii_status=0x782d
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90288D2, ATA DISK drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
VP_IDE: IDE controller at PCI slot 00:07.1
PCI: Unable to reserve I/O region #5:10@d000 for device 00:07.1
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
VP_IDE: port 0x01f0 already claimed by ide0
VP_IDE: port 0x0170 already claimed by ide1
VP_IDE: neither IDE port enabled (BIOS)
hda: host protected area => 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdd: host protected area => 1
hdd: 5627664 sectors (2881 MB) w/256KiB Cache, CHS=5583/16/63, UDMA(33)
 hdd: hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-12102B        Rev: NS1D
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
hcd-pci.c: uhci-hcd @ 00:07.2, VIA Technologies, Inc. USB
hcd-pci.c: irq 5, io base 0000d400
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at 0
hub.c: 2 ports detected
hcd-pci.c: uhci-hcd @ 00:07.3, VIA Technologies, Inc. USB (#2)
hcd-pci.c: irq 5, io base 0000d800
hcd.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at 0
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 0.9.0rc2 (Wed Jun 19 08:56:25 2002 UTC).
ALSA device list:
  #0: VIA 82C686A/B at 0xdc00, irq 12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub.c: new USB device 00:07.2-1, assigned address 2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 88k freed
hub.c: USB hub found at 1
hub.c: 3 ports detected
----------it dies here--------

Note that if no usb devices are plugged in the last message is "Freeing
unused kernel memory...".

It seems to be not completely dead however since if I then plug in my
usb mouse and keyboard I get a message printed that a new usb device has
been found.

Any ideas anyone?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
