Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbSLRNbB>; Wed, 18 Dec 2002 08:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbSLRNbB>; Wed, 18 Dec 2002 08:31:01 -0500
Received: from pullyou.nist.gov ([129.6.16.93]:44483 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id <S267245AbSLRNa6>;
	Wed, 18 Dec 2002 08:30:58 -0500
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Trident/ALi 5451 problem, 2.4.20-ac2
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Wed, 18 Dec 2002 08:38:31 -0500
Message-ID: <9cf4r9btpk8.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Just tried 2.4.20-ac2 on my Fujitsu P-2040, and it seems to have a
problem initializing the sound:

(from dmesg)

Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h,
 17:35:49 Dec 16 2002
PCI: Found IRQ 9 for device 00:04.0
trident: ALi Audio Accelerator found at IO 0x1000, IRQ 9
ALi 5451 did not come out of reset.
trident_ac97_init: error resetting 5451.

I'm attaching the full dmesg below.  trident is compiled into the
kernel.

Thanks in advance,
(and, Alan, the ALi IDE init works fine now, thanks!)

Ian


--=-=-=
Content-Disposition: attachment; filename=euphrates-dmesg

Linux version 2.4.20-ac2 (root@euphrates) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Mon Dec 16 17:31:17 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000016fe0000 (usable)
 BIOS-e820: 0000000016fe0000 - 0000000016fefc00 (ACPI data)
 BIOS-e820: 0000000016fefc00 - 0000000016ff0000 (ACPI NVS)
 BIOS-e820: 0000000016ff0000 - 0000000017100000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
367MB LOWMEM available.
On node 0 totalpages: 94176
zone(0): 4096 pages.
zone(1): 90080 pages.
zone(2): 0 pages.
Kernel command line: ro hdc=ide-scsi
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 859.299 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1703.93 BogoMIPS
Memory: 367128k/376704k available (1334k kernel code, 7000k reserved, 491k data, 116k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=46163 max_file_pages=0 max_inodes=0 max_dentries=46163
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 867 MHz
CPU: Code Morphing Software revision 4.3.0-9-197
CPU: 20020207 23:55 official release 4.3.0#7
CPU:     After generic, caps: 0080893f 0081813f 0000004e 00000000
CPU:             Common caps: 0080893f 0081813f 0000004e 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfd88e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
floppy0: no floppy controllers found
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized r128 2.2.0 20010917 on minor 1
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:0f.0
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3018GAP, ATA DISK drive
blk: queue c03128c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 58605120 sectors (30006 MB), CHS=3648/255/63, UDMA(66)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
es1371: version v0.30 time 17:35:39 Dec 16 2002
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 17:35:49 Dec 16 2002
PCI: Found IRQ 9 for device 00:04.0
trident: ALi Audio Accelerator found at IO 0x1000, IRQ 9
ALi 5451 did not come out of reset.
trident_ac97_init: error resetting 5451.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 9 for device 00:0c.0
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0cf8, PCI irq9
Socket status: 30000006
kjournald starting.  Commit interval 30 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 116k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:02.0
usb-ohci.c: USB OHCI at membase 0xd781d000, IRQ 11
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
Adding Swap: 819272k swap-space (priority -1)
kjournald starting.  Commit interval 30 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 30 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 30 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 30 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 578 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 9 for device 00:13.0
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[fc007000-fc0077ff]  Max Packet=[2048]
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1F15
  Type:   CD-ROM                             ANSI SCSI revision: 02
ieee1394: Host added: Node[00:1023]  GUID[00000e1000b029cc]  [Linux OHCI-1394]
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 9 for device 00:10.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd78db800, 00:e0:00:ae:45:01, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

--=-=-=--

