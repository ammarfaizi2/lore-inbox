Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTIOUi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbTIOUi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:38:57 -0400
Received: from adsl-68-22-91-52.dsl.wotnoh.ameritech.net ([68.22.91.52]:34568
	"EHLO gate.cyberMalex.com") by vger.kernel.org with ESMTP
	id S261592AbTIOUip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:38:45 -0400
Date: Mon, 15 Sep 2003 16:37:41 -0400
From: todd1@gate.cyberMalex.com
Message-Id: <200309152037.h8FKbfV7004301@gate.cyberMalex.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 panic w cpqarray root=/dev/ida/c0d0p1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a problem booting the 2.6.0-test5 kernel. It
seems to be confused about my root disk on a cpqarray
controler. The configuration works fine with v2.4.22.
Here is are sections of the boot messages, first from
the 2.6 failure, and then a normal startup from the 2.4.22
kernel. 

------------------------- v2.6.0-test5 -----------------------------
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.4.5)
Found 1 controler(s)
cpqarray: Finding drives on ida0 (Integrated Array)
cpqarray ida/c0d0: blksz=512 nr_blks=106659360
 ida/c0d0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Compaq CISS Driver (v 2.5.0)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2c00-0x2c07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2c08-0x2c0f, BIOS settings: hdc:pio, hdd:pio
hda: Compaq CRN-8241B, ATAPI CD/DVD-ROM drive
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
...
input: PS/2 Generic Mouse on isa0060/seriol
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
EISA: Mainboard CPQ0692 detected.
Connot allocate resource for EISA slot 1
Connot allocate resource for EISA slot 2
Connot allocate resource for EISA slot 3
Connot allocate resource for EISA slot 4
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "ida/c0d0p1" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

------------------------- v2.4.22 -----------------------------
Linux version 2.4.20-8 (bhcompile@porky.devel.redhat.com) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13 17:54:28 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffc000 (usable)
 BIOS-e820: 000000000fffc000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65532
zone(0): 4096 pages.
zone(1): 61436 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/ida/c0d0p1
Initializing CPU#0
Detected 731.069 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1458.17 BogoMIPS
Memory: 252884k/262128k available (1347k kernel code, 6812k reserved, 999k data, 132k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0084, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 03
PCI: Device 00:00 not found by BIOS
PCI: Device 00:01 not found by BIOS
PCI: Device 00:78 not found by BIOS
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2c00-0x2c07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2c08-0x2c0f, BIOS settings: hdc:pio, hdd:pio
hda: Compaq CRN-8241B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 249k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
 scsi_register allocating 3788 bytes for FC HBA
 ioremap'd Membase: d083de00
  HBA Tachyon RevId 1.2
Allocating 119808 for 576 Exchanges @ c18a0000
Allocating 112904 for LinkQ @ c1880000 (576 elements)
Allocating 104456 for TachSEST for 512 Exchanges
  cpqfcTS: writing IMQ BASE 18C0000h    PI 18C4000h
  cpqfcTS: SEST c1840000(virt): Wrote base 1840000h @ d083df40
scsi0 : Compaq FibreChannel HBA Tachyon TS HPFC-5166A/1.2: WWN 500508B200154740
 on PCI bus 3 device 0xa0fc irq 11 IObaseL 0x4400, MEMBASE 0xc6dffe00
PCI bus width 64 bits, bus speed 33 MHz
FCP-SCSI Driver v2.1.2
GBIC detected: Short-wave.  LPSM 0h Monitor
Compaq SMART2 Driver (v 2.4.25)
cpqarray: Device 0x10 has been found at bus 0 dev 1 func 0
cpqarray: Finding drives on ida0 (Integrated Array)
cpqarray ida/c0d0: blksz=512 nr_blks=106659360
cpqarray: Starting firmware's background processing
blk: queue c03be840, I/O limit 4095Mb (mask 0xffffffff)
Partition check:
 ida/c0d0: p1 p2 p3 p4 < p5 p6cpqfcTS: New FC port 000001h WWN: 100000E00201A196 SCSI Chan/Trgt 0/0
 p7 p8 p9 >
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
