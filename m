Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTK3XQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTK3XQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:16:59 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:45317
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S261877AbTK3XQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:16:46 -0500
Date: Mon, 1 Dec 2003 00:16:41 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA setting not available on 2.4.23 as a module
Message-ID: <20031130231640.GA687@man.beta.es>
References: <20031130195815.GA2409@man.beta.es> <200311302115.07898.bzolnier@elka.pw.edu.pl> <20031130224219.GA691@man.beta.es> <200311302347.16802.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311302347.16802.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing, I've seen the PIIX_TUNNING or however it was called, option still
around in several places on the kernel tree, one of them was in the help,
while this option is not on the ide driver anymore.

> Please send dmesg and .config for this case (built-in Intel IDE driver).

No problem, there it goes:

Linux version 2.4.23 (root@pul) (gcc version 3.3.2 (Debian)) #1 Sun Nov 30 23:15:20 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=901 isapnp_reserve_irq=5
Initializing CPU#0
Detected 199.434 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.13 BogoMIPS
Memory: 127356k/131072k available (1164k kernel code, 3328k reserved, 459k data, 88k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb590, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB16 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875J detected with Symbios NVRAM
sym53c875J-0: rev 0x4 on pci bus 0 device 9 function 0 irq 11
sym53c875J-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875J-0: on-chip RAM at 0xe1005000
sym53c875J-0: restart (scsi reset).
sym53c875J-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
  Vendor: SEAGATE   Model: ST1480            Rev: 5830
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST1480            Rev: 5830
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: CONNER    Model: CFP1080S LKM1.05  Rev: 4649
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875J-0-<3,*>: FAST-10 SCSI 10.0 MB/s (100.0 ns, offset 15)
  Vendor: HP        Model: 2.13GB B 50-0658  Rev: 0658
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: PIONEER   Model: CD-ROM DR-U16S    Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9600   Rev: 1.0a
  Type:   CD-ROM                             ANSI SCSI revision: 04
sym53c875J-0-<2,0>: tagged command queue depth set to 8
sym53c875J-0-<3,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
sym53c875J-0-<0,*>: FAST-5 SCSI 5.0 MB/s (200.0 ns, offset 15)
SCSI device sda: 843284 512-byte hdwr sectors (432 MB)
Partition check:
 sda: sda1
sym53c875J-0-<1,*>: FAST-5 SCSI 5.0 MB/s (200.0 ns, offset 15)
SCSI device sdb: 843284 512-byte hdwr sectors (432 MB)
 sdb: sdb1
sym53c875J-0-<2,*>: FAST-10 SCSI 10.0 MB/s (100.0 ns, offset 15)
SCSI device sdc: 2074880 512-byte hdwr sectors (1062 MB)
 sdc: sdc1 sdc2 sdc3
SCSI device sdd: 4165272 512-byte hdwr sectors (2133 MB)
 sdd: sdd1 sdd2 sdd3
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
sym53c875J-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 16)
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sym53c875J-0-<6,*>: FAST-10 SCSI 10.0 MB/s (100.0 ns, offset 15)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   220.000 MB/sec
   32regs    :   164.800 MB/sec
   pII_mmx   :   305.600 MB/sec
   p5_mmx    :   363.200 MB/sec
raid5: using function: p5_mmx (363.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 000000c8]
 [events: 000000c8]
 [events: 0000005a]
 [events: 0000005a]
md: autorun ...
md: considering sdd2 ...
md:  adding sdd2 ...
md:  adding sdc2 ...
md: created md1
md: bind<sdc2,1>
md: bind<sdd2,2>
md: running: <sdd2><sdc2>
md: sdd2's event counter: 0000005a
md: sdc2's event counter: 0000005a
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdd2 operational as mirror 1
raid1: device sdc2 operational as mirror 0
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: sdd2 [events: 0000005b]<6>(write) sdd2's sb offset: 102208
md: sdc2 [events: 0000005b]<6>(write) sdc2's sb offset: 102208
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1,1>
md: bind<sdb1,2>
md: running: <sdb1><sda1>
md: sdb1's event counter: 000000c8
md: sda1's event counter: 000000c8
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid0: looking at sda1
raid0:   comparing sda1(421120) with sda1(421120)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdb1
raid0:   comparing sdb1(421120) with sda1(421120)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sda1 ... contained as device 0
  (421120) is smallest!.
raid0: checking sdb1 ... contained as device 1
raid0: zone->nb_dev: 2, size: 842240
raid0: current zone offset: 421120
raid0: done.
raid0 : md_size is 842240 blocks.
raid0 : conf->smallest->size is 842240 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: sdb1 [events: 000000c9]<6>(write) sdb1's sb offset: 421120
md: sda1 [events: 000000c9]<6>(write) sda1's sb offset: 421120
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 88k freed
Adding Swap: 92060k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,1), internal journal
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: SAMSUNG SV1022D, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 19931184 sectors (10205 MB) w/472KiB Cache, CHS=19773/16/63
 hda: [PTBL] [1240/255/63] hda1 hda2
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x260: 00 4f 4c 00 60 ca
eth0: NE2000 found at 0x260, using IRQ 5.
8139too Fast Ethernet driver 0.9.26
eth1: RealTek RTL8139 at 0xc8846000, 00:48:54:6a:5c:e6, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139B'
lp0: using parport0 (polling).
 [events: 000000e4]
 [events: 000000e4]
 [events: 000000e4]
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding md0 ...
md: created md5
md: bind<md0,1>
md: bind<sdc1,2>
md: bind<sdd1,3>
md: running: <sdd1><sdc1><md0>
md: sdd1's event counter: 000000e4
md: sdc1's event counter: 000000e4
md: md0's event counter: 000000e4
md5: max total readahead window set to 496k
md5: 2 data-disks, max readahead per data-disk: 248k
raid5: device sdd1 operational as raid disk 2
raid5: device sdc1 operational as raid disk 1
raid5: device md0 operational as raid disk 0
raid5: allocated 3284kB for md5
raid5: raid level 5 set md5 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:md0
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdc1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sdd1
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:md0
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:sdc1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sdd1
md: updating md5 RAID superblock on device
md: sdd1 [events: 000000e5]<6>(write) sdd1's sb offset: 842816
md: sdc1 [events: 000000e5]<6>(write) sdc1's sb offset: 842816
md: md0 [events: 000000e5]<6>(write) md0's sb offset: 842176
md: ... autorun DONE.
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,51), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0x6300, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
device eth0 entered promiscuous mode
device eth1 entered promiscuous mode
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
eth1: Promiscuous mode enabled.
eth1: Promiscuous mode enabled.
eth1: Promiscuous mode enabled.
eth1: Promiscuous mode enabled.
eth1: Promiscuous mode enabled.
br0: port 2(eth1) entering listening state
br0: port 1(eth0) entering listening state
br0: port 1(eth0) entering blocking state
br0: port 2(eth1) entering learning state
br0: port 2(eth1) entering forwarding state
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
br0: neighbour 7fff.00:00:21:00:2d:c0 lost on port 1(eth0)
br0: port 1(eth0) entering listening state
br0: port 1(eth0) entering blocking state


CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_M586MMX=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_PACKET=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IPV6_SCTP__=y
CONFIG_BRIDGE=y
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=3
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_ISA=y
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_BT848=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_PRINTER=m
CONFIG_USB_SCANNER=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_LOG_BUF_SHIFT=0

Regards...
-- 
Manty/BestiaTester -> http://manty.net
