Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSLBGkv>; Mon, 2 Dec 2002 01:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSLBGkv>; Mon, 2 Dec 2002 01:40:51 -0500
Received: from h68-146-142-19.cg.shawcable.net ([68.146.142.19]:4736 "EHLO
	h68-146-142-19.localdomain") by vger.kernel.org with ESMTP
	id <S265169AbSLBGkq>; Mon, 2 Dec 2002 01:40:46 -0500
Subject: Re: scsi-eide interrupt/ read errors with cdparanoia; CDROM works
	fine otherwise; dmesq included; 2.4.20
From: Kim Lux <lux@diesel-research.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1038808565.1397.12.camel@h68-146-142-19.localdomain>
References: <1038808565.1397.12.camel@h68-146-142-19.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1038811691.1085.5.camel@h68-146-142-19.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 01 Dec 2002 23:48:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one:

One more thing: it is usually impossible to kill the process after the
crash.  I thought that one could ALWAYS kill a Unix process !

Kim Lux 



[krlux@h68-146-142-19 blondie]$ cdparanoia -svB
cdparanoia III release 9.8 (March 23, 2001)
(C) 2001 Monty <monty@xiph.org> and Xiphophorus

Report bugs to paranoia@xiph.org
http://www.xiph.org/paranoia/

Checking /dev/cdrom for cdrom...
        Testing /dev/cdrom for cooked ioctl() interface
                /dev/scd0 is not a cooked ioctl CDROM.
        Testing /dev/cdrom for SCSI interface
                generic device: /dev/sg0
                ioctl device: /dev/scd0

Found an accessible SCSI CDROM drive.
Looking at revision of the SG interface in use...
        SG interface version 3.1.24; OK.

CDROM model sensed sensed: CREATIVE CD2423E  NC102 1.02

Checking for SCSI emulation...
        Drive is ATAPI (using SCSI host adaptor emulation)

Checking for MMC style command set...
        Drive is MMC style
        DMA scatter/gather table entries: 256
        table entry size: 32768 bytes
        maximum theoretical transfer: 3566 sectors
        Setting default read size to 13 sectors (30576 bytes).

Verifying CDDA command set...
        Expected command set reads OK.

Table of contents (audio tracks only):
track        length               begin        copy pre ch
===========================================================
  1.    16065 [03:34.15]        0 [00:00.00]    OK   no  2
  2.    15645 [03:28.45]    16065 [03:34.15]    OK   no  2
  3.    10787 [02:23.62]    31710 [07:02.60]    OK   no  2
  4.    13940 [03:05.65]    42497 [09:26.47]    OK   no  2
  5.    18853 [04:11.28]    56437 [12:32.37]    OK   no  2
  6.    22362 [04:58.12]    75290 [16:43.65]    OK   no  2
  7.    17452 [03:52.52]    97652 [21:42.02]    OK   no  2
  8.    17328 [03:51.03]   115104 [25:34.54]    OK   no  2
  9.    10438 [02:19.13]   132432 [29:25.57]    OK   no  2
 10.    17255 [03:50.05]   142870 [31:44.70]    OK   no  2
TOTAL  160125 [35:35.00]    (audio only)

Ripping from sector       0 (track  1 [0:00.00])
          to sector  160124 (track 10 [3:50.04])

outputting to track01.cdda.wav

 (== PROGRESS == [          ++     + +++ ++    -| 016064 00 ] == :^D *
==)

outputting to track02.cdda.wav

 (== PROGRESS == [----------------------+-------| 031709 00 ] == :^D *
==)

outputting to track03.cdda.wav

 (== PROGRESS == [------->                      | 034134 00 ] == :-) o
==)
SCSI transport error: timeout waiting to read packet

scsi_read error: sector=34278 length=13 retry=0
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error reading command from device
                 System error: Success

SCSI transport error: timeout waiting to write packet

scsi_read error: sector=34278 length=6 retry=1
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error writing packet command to device
                 System error: Invalid argument
 (== PROGRESS == [------->                      | 034247 00 ] == :-) O
==)
SCSI transport error: timeout waiting to read packet

scsi_read error: sector=34279 length=13 retry=0
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error reading command from device
                 System error: Success

SCSI transport error: timeout waiting to write packet

scsi_read error: sector=34279 length=6 retry=1
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Error writing packet command to device
                 System error: Invalid argument
scsi_read error: sector=34279 length=3 retry=2
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Illegal SCSI request (rejected by
target)
                 System error: Invalid argument
scsi_read error: sector=34279 length=1 retry=3
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Illegal SCSI request (rejected by
target)
                 System error: Invalid argument
scsi_read error: sector=34279 length=1 retry=4
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Illegal SCSI request (rejected by
target)
                 System error: Invalid argument
scsi_read error: sector=34279 length=1 retry=5
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Illegal SCSI request (rejected by
target)
                 System error: Invalid argument
scsi_read error: sector=34279 length=1 retry=6
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Illegal SCSI request (rejected by
target)
                 System error: Invalid argument
scsi_read error: sector=34279 length=1 retry=7
                 Sense key: 0 ASC: 0 ASCQ: 0
                 Transport error: Illegal SCSI request (rejected by
target)
                 System error: Invalid argument

dmesg:


[krlux@h68-146-142-19 krlux]$ dmesg
Linux version 2.4.20 (root@h68-146-142-19) (gcc version 3.2 20020903
(Red Hat Linux 8.0 3.2-7)) #5 Sat Nov 30 11:04:39 MST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Kernel command line: ro root=LABEL=/ hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 1659.627 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3316.12 BogoMIPS
Memory: 516048k/524288k available (1236k kernel code, 7852k reserved,
452k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
hdd: CREATIVE CD2423E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02f0d64, I/O limit 4095Mb (mask 0xffffffff)
hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63,
UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 128k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 124k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
SiS router pirq escape (99)
SiS router pirq escape (99)
usb-ohci.c: USB OHCI at membase 0xe0848000, IRQ 10
usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 5 for device 00:02.2
PCI: Sharing IRQ 5 with 00:0f.0
usb-ohci.c: USB OHCI at membase 0xe084a000, IRQ 5
usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Adding Swap: 1024120k swap-space (priority -1)
hub.c: new USB device 00:02.2-1, assigned address 2
: USB HID v1.10 Joystick [Logitech WingMan Attack 2] on usb2:2.0
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: CREATIVE  Model: CD2423E  NC102    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: Printer, Lexmark International Lexmark Optra S 1855
ip_tables: (C) 2000-2002 Netfilter core team
sis900.c: v1.08.06 9/24/2002
PCI: Assigned IRQ 5 for device 00:03.0
divert: allocating divert_blk for eth0
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd800, IRQ 5, 00:07:95:31:18:04.
eth0: Media Link On 10mbps half-duplex
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: Printer, Lexmark International Lexmark Optra S 1855
lp0: using parport0 (polling).
lp0: console ready
Creative EMU10K1 PCI Audio Driver, version 0.20, 10:48:48 Nov 30 2002
PCI: Found IRQ 5 for device 00:0f.0
PCI: Sharing IRQ 5 with 00:02.2
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xd400-0xd41f, IRQ 5
ac97_codec: AC97 Audio codec, id: EMC40(Unknown)
emu10k1: SBLive! 5.1 card detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 2x/20x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
scsi : aborting command due to timeout : pid 5678, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e6 00 00 0d f8 00 00
hdd: irq timeout: status=0xd0 { Busy }
hdd: DMA disabled
hdd: ATAPI reset complete
scsi : aborting command due to timeout : pid 5692, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 0d f8 00 00
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
scsi : aborting command due to timeout : pid 5693, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 03 f8 00 00
hdd: lost interrupt
scsi : aborting command due to timeout : pid 5694, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 01 f8 00 00
hdd: lost interrupt
scsi : aborting command due to timeout : pid 5695, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 01 f8 00 00
hdd: lost interrupt
scsi : aborting command due to timeout : pid 5696, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 01 f8 00 00
hdd: lost interrupt
scsi : aborting command due to timeout : pid 5697, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 01 f8 00 00
hdd: lost interrupt
scsi : aborting command due to timeout : pid 5698, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 01 f8 00 00
hdd: lost interrupt
scsi : aborting command due to timeout : pid 5699, scsi0, channel 0, id
0, lun 0 UNKNOWN(0xbe) 00 00 00 85 e7 00 00 01 f8 00 00
hdd: lost interrupt
[krlux@h68-146-142-19 krlux]$





-- 
Kim Lux <lux@diesel-research.com>
