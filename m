Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbUAHNs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbUAHNs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:48:56 -0500
Received: from 212-214-141-205.v-by.wtnord.net ([212.214.141.205]:53892 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S264464AbUAHNsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:48:45 -0500
Date: Thu, 8 Jan 2004 14:48:40 +0100
From: Daniel Brahneborg <daniel.com@wtnord.net>
To: linux-kernel@vger.kernel.org
Subject: CRASH: SATA + 8139 + Via Rhine = STOP
Message-ID: <20040108144840.E2500@nettis.grimsta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm building a little firewall for myself, and has bought
an Abit KV7 motherboard with a Via Rhine network card.
On the other side I have an 8139 based card.  I also have
a Silicon Image Serial-ATA card on the PCI bus.

Both nics work fine, as long as the SATA Card isn't there.
When it is, I can only activate one of the cards.  If I
try to activate both of them, or try to activate two 8139
cards, the machine comes to a complete stop, forcing me
to do a power cycle to bring it back.  Is there a conflict
between the cards that can't be resolved?

I've appended the output from lspci -v and dmesg.

/Basic

lspci -v

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Capabilities: [80] Power Management version 2

00:08.0 VGA compatible controller: S3 Inc. 86c968 [Vision 968 VRAM] rev 0 (prog-if 00 [VGA])
	Flags: stepping, medium devsel, IRQ 12
	Memory at 20000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a000 [size=256]
	Memory at ea000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:0b.0 Unknown mass storage controller: CMD Technology Inc: Unknown device 3112 (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 3112
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
	I/O ports at a400 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at ac00 [size=8]
	I/O ports at b000 [size=4]
	I/O ports at b400 [size=16]
	Memory at ea001000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at b800 [size=8]
	I/O ports at bc00 [size=4]
	I/O ports at c000 [size=8]
	I/O ports at c400 [size=4]
	I/O ports at c800 [size=16]
	I/O ports at cc00 [size=256]
	Capabilities: [c0] Power Management version 2

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at ea002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at e400 [size=256]
	Memory at ea003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

dmesg:

Linux version 2.4.23-xfs (root@fw.grimsta) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #8 Fri Dec 26 13:21:26 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
510MB LOWMEM available.
On node 0 totalpages: 130800
zone(0): 4096 pages.
zone(1): 126704 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda3
Initializing CPU#0
Detected 819.311 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1635.12 BogoMIPS
Memory: 514816k/523200k available (1587k kernel code, 7996k reserved, 460k data, 76k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfaf40, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3227] at 00:11.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
SGI XFS snapshot-2.4.23-2003-12-01_00:33_UTC with ACLs, no debug enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Real Time Clock Driver v1.10e
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: FUJITSU MHM2060AT, ATA DISK drive
hdd: MATSHITA CD-RW CW-7586, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 11733120 sectors (6007 MB) w/2048KiB Cache, CHS=730/255/63
hdd: attached ide-cdrom driver.
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1176.000 MB/sec
   32regs    :   909.600 MB/sec
   pII_mmx   :  1920.800 MB/sec
   p5_mmx    :  2464.400 MB/sec
raid5: using function: p5_mmx (2464.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 76k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Adding Swap: 522104k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
libata version 0.81 loaded.
ata_sil version 0.51
PCI: Found IRQ 10 for device 00:0b.0
ata1: SATA max UDMA/133 cmd 0xE0870080 ctl 0xE087008A bmdma 0xE0870000 irq 10
ata2: SATA max UDMA/133 cmd 0xE08700C0 ctl 0xE08700CA bmdma 0xE0870008 irq 10
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:20ff
ata2: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata2: dev 0 configured for UDMA/133
scsi0 : ata_sil
scsi1 : ata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_via version 0.11
ata3: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 11
ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 11
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:00ff
ata3: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata3: dev 0 configured for UDMA/133
ata4: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:00ff
ata4: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
ata4: dev 0 configured for UDMA/133
scsi2 : sata_via
scsi3 : sata_via
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
 sda: sda1 sda2
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
 sdb: sdb1 sdb2
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
 sdc: sdc1 sdc2
SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
 sdd: sdd1 sdd2
 [events: 00000010]
 [events: 00000010]
 [events: 00000010]
 [events: 00000010]
md: autorun ...
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sdd2 ...
md:  adding sdc2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2,1>
md: bind<sdc2,2>
md: bind<sdd2,3>
md: bind<sdb2,4>
md: running: <sdb2><sdd2><sdc2><sda2>
md: sdb2's event counter: 00000010
md: sdd2's event counter: 00000010
md: sdc2's event counter: 00000010
md: sda2's event counter: 00000010
md: md0: raid array is not clean -- starting background reconstruction
md0: max total readahead window set to 3072k
md0: 3 data-disks, max readahead per data-disk: 1024k
raid5: device sdb2 operational as raid disk 3
raid5: device sdd2 operational as raid disk 1
raid5: device sdc2 operational as raid disk 0
raid5: device sda2 operational as raid disk 2
raid5: allocated 4330kB for md0
raid5: raid level 5 set md0 active with 4 out of 4 devices, algorithm 0
raid5: raid set md0 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdc2
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdd2
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sda2
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdb2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdc2
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdd2
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sda2
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdb2
md: updating md0 RAID superblock on device
md: sdb2 [events: 00000011]<6>(write) sdb2's sb offset: 152191680
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 152191488 blocks.
md: sdd2 [events: 00000011]<6>(write) sdd2's sb offset: 152191680
md: sdc2 [events: 00000011]<6>(write) sdc2's sb offset: 152191680
md: sda2 [events: 00000011]<6>(write) sda2's sb offset: 152191680
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem md(9,0)
Ending clean XFS mount for filesystem: md(9,0)

----- End forwarded message -----

/Basic

