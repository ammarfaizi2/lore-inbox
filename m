Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313813AbSDIHm0>; Tue, 9 Apr 2002 03:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313814AbSDIHmZ>; Tue, 9 Apr 2002 03:42:25 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:9115 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313813AbSDIHmW>;
	Tue, 9 Apr 2002 03:42:22 -0400
Message-ID: <3CB29B5D.2080804@candelatech.com>
Date: Tue, 09 Apr 2002 00:42:21 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: asus terminator issues.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After giving up on a Shuttle SV24, I exchanged it for
an Asus Terminator, another relatively cute and small box.

RH 2.4.9-31 has all kinds of issues, including endless kernel
pointer exceptions somewhere down in the file system...

2.4.18 has the video display problem, so I went with
2.4.19-pre5-ac3.  At first blush, it seems to work
fine, but just a minute or two ago, X locked up hard.

I'm curious if anyone is successfully using this type of
machine?

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
00:0e.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8a26 (rev 03)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)

Processor: AMD 1.8

I'm currently running RH 7.2 with all the updates, including XFree 4.1.

I'm downloading the latest Skipjack beta now, with XF 4.2, which may help
the video lockup problem.

Any ideas are welcome!

Thanks,
Ben

dmesg output:

Linux version 2.4.19-pre5-ac3 (greear@grok.yi.org) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #3 Mon Apr 8 21:11:45 MST 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000efec000 (usable)
  BIOS-e820: 000000000efec000 - 000000000efef000 (ACPI data)
  BIOS-e820: 000000000efef000 - 000000000efff000 (reserved)
  BIOS-e820: 000000000efff000 - 000000000f000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 61420
zone(0): 4096 pages.
zone(1): 57324 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda2
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1533.869 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 239820k/245680k available (1139k kernel code, 5472k reserved, 315k data, 264k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(TM) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1533.8515 MHz.
..... host bus clock speed is 266.7566 MHz.
cpu: 0, clocks: 2667566, slice: 1333783
CPU0<T0:2667552,T1:1333760,D:9,S:1333783,C:2667566>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0c20, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 464 slots per queue, batch=116
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 2B020H1, ATA DISK drive
hdb: ASUS CD-S520/A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=2491/255/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
  hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 259k freed
VFS: Mounted root (ext2 filesystem).
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 264k freed
Adding Swap: 522104k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 21:20:08 Apr  8 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:07.2
PCI: Sharing IRQ 9 with 00:07.3
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:07.3
PCI: Sharing IRQ 9 with 00:07.2
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
NET4: Linux IPX 0.47 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
NET4: AppleTalk 0.18a for Linux NET4.0
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 10 for device 00:12.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcf869000, 00:e0:18:4c:5e:3e, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
Linux Tulip driver version 0.9.15-pre10 (Mar 8, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0x9800, 00:80:C8:B9:1E:45, IRQ 10.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at 0x9400, 00:80:C8:B9:1E:46, IRQ 5.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at 0x9000, 00:80:C8:B9:1E:47, IRQ 9.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
eth4: Digital DS21143 Tulip rev 65 at 0x8800, 00:80:C8:B9:1E:48, IRQ 11.
spurious 8259A interrupt: IRQ7.





-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


