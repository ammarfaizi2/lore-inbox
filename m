Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSEFMqX>; Mon, 6 May 2002 08:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314417AbSEFMqW>; Mon, 6 May 2002 08:46:22 -0400
Received: from duneyr.obbit.se ([194.165.245.23]:47587 "EHLO mail.obbit.se")
	by vger.kernel.org with ESMTP id <S314413AbSEFMqV>;
	Mon, 6 May 2002 08:46:21 -0400
Message-ID: <3CD67A89.9040007@obbit.se>
Date: Mon, 06 May 2002 14:43:53 +0200
From: Peter Hellman <listuser@obbit.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502 Debian/1.0rc1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: alpha + raid 2.4.19-pre8 kernel crash
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Made a raid 1 from  two partitions, one disk also has root partition.
All is well until I try to mkfs on the md0 device, flips me right back 
to SRM with the following message :

halted cpu0
halt code=7
machine check while PAL mode
PC=1d4f0

Another issue is that with all tried 2.4.x kernels halt or reboot will 
lock the machine, forcing hard reset.
Kernel compiled as generic, since it does not boot using the system type 
from /proc/cpuinfo
I'd be happy to give more info, or test something..
2.4.18 gave me a oops, and the box survived :

CIA machine check: vector=0x670 pc=0xfffffc0000456e6c code=0x98
machine check type: processor detected hard error
pc = [<fffffc0000456e6c>]  ra = [<fffffc00004570c4>]  ps = 0000    Not 
tainted
v0 = 0000000000000008  t0 = 0000000000000000  t1 = 0000000000000006
t2 = fffffc289fa997f8  t3 = 0000000000000000  t4 = fffffc289fa997fc
t5 = fffffc289fa997f4  t6 = 0000000000000001  t7 = fffffc001e800000
a0 = fffffc001faa7000  a1 = fffffc001dbc9cc0  a2 = fffffc001dbc9cc0
a3 = 0000000000000000  a4 = 0000000000000002  a5 = fffffc001faa7018
t8 = 0000000000000000  t9 = 000000287fff2800  t10= 0000000000000006
t11= fffffc001faa7020  pv = fffffc0000456ee0  at = fffffc001faa701c
gp = fffffc00005d5d30  sp = fffffc001e803c48
CIA machine check: vector=0x670 pc=0xfffffc00004c9ce8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc00004c9ce8>]  ra = [<fffffc000034a0a0>]  ps = 0000    Not 
tainted
v0 = 00000000000007d8  t0 = 0000000000000000  t1 = fffffc001e803db8
t2 = 0000000000000000  t3 = 00000000000007d0  t4 = 00000000001fddc0
t5 = fffffc001da99828  t6 = 000000012003d788  t7 = fffffc001e800000
a0 = fffffc001da9c880  a1 = 00000000000004d7  a2 = fffffc001da9c880
a3 = 0000000000000001  a4 = fffffc0000363d40  a5 = 000000011ffffa4c
t8 = 0000000000000000  t9 = 000002000019f1d8  t10= 0000000000000008
t11= 0000000000000001  pv = fffffc00004c9be0  at = fffffc000034a0cc
gp = fffffc00005d5d30  sp = fffffc001e803e48


Thank you in advance and have a nice day.
//Peter Hellman

cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Noritake
system variation        : 0
system revision         : 0
system serial number    : PY81500046
cycle frequency [Hz]    : 500000000
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 994.44
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : DIGITAL Server 3000 Model 3305 6500A
cpus detected           : 1

Personalities : [raid1]
read_ahead 1024 sectors
md0 : active raid1 sdb1[1] sda2[0]

Linux version 2.4.18 (root@freja) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #5 Tue May 3 17:20:49 CEST 2022
Booting GENERIC on Noritake using machine vector Noritake-Primo from SRM
Command line: ro root=/dev/sda1
memcluster 0, usage 1, start        0, end      236
memcluster 1, usage 0, start      236, end    65511
memcluster 2, usage 1, start    65511, end    65536
freeing pages 236:384
freeing pages 778:65511
reserving pages 778:779
pci: cia revision 2
On node 0 totalpages: 65511
zone(0): 65511 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/sda1
Using epoch = 1980
Console: colour VGA+ 80x25
Calibrating delay loop... 994.44 BogoMIPS
Memory: 510816k/524088k available (1783k kernel code, 11384k reserved, 
692k data, 336k init)
Dentry-cache hash table entries: 65536 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 32768 (order: 6, 524288 bytes)
Mount-cache hash table entries: 8192 (order: 4, 131072 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 262144 bytes)
Page-cache hash table entries: 65536 (order: 6, 524288 bytes)
POSIX conformance testing by UNIFIX
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed tbia test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: ARC console epoch (1980) detected
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
eth0: DE500-BA at 0x9c00 (PCI bus 0, device 11), h/w address 
00:00:f8:08:56:f7,
      and requires IRQ18 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
eth1: DE500-BA at 0x9c80 (PCI bus 0, device 14), h/w address 
08:00:2b:c3:51:3a,
      and requires IRQ24 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2944 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

qlogicisp : new isp1020 revision ID (5)
qlogicisp : new isp1020 revision ID (5)
scsi1 : QLogic ISP1020 SCSI on PCI bus 00 device 28 irq 17 I/O base 0x9000
scsi2 : QLogic ISP1020 SCSI on PCI bus 00 device 60 irq 20 I/O base 0x9400
  Vendor: Quantum   Model: XP34550J          Rev: LYJ2
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: Quantum   Model: XP34550J          Rev: LYJ2
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RRD46   (C) DEC   Rev: 1337
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
SCSI device sda: 8388315 512-byte hdwr sectors (4295 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 8388315 512-byte hdwr sectors (4295 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 5, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 336k freed
Adding Swap: 578320k swap-space (priority -1)
 [events: 00000006]
 [events: 00000006]
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2,1>
md: bind<sdb1,2>
md: running: <sdb1><sda2>
md: sdb1's event counter: 00000006
md: sda2's event counter: 00000006
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 248k
md0: 1 data-disks, max readahead per data-disk: 248k
raid1: device sdb1 operational as mirror 1
raid1: device sda2 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: sdb1 [events: 00000007]<6>(write) sdb1's sb offset: 2088384
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 
KB/sec) for reconstruction.
md: using 248k window, over a total of 2088384 blocks.
md: sda2 [events: 00000007]<6>(write) sda2's sb offset: 2088384
md: ... autorun DONE.
eth0: media is 100Mb/s.


