Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSE2RjZ>; Wed, 29 May 2002 13:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSE2RjY>; Wed, 29 May 2002 13:39:24 -0400
Received: from ares.sdinet.de ([195.21.215.20]:2564 "HELO ares.sdinet.de")
	by vger.kernel.org with SMTP id <S314243AbSE2RjV>;
	Wed, 29 May 2002 13:39:21 -0400
Date: Wed, 29 May 2002 19:39:24 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: linux-kernel@vger.kernel.org
Subject: NCR-SCSI (CACHE?) Problems on 2.4.19-pre9
Message-ID: <Pine.LNX.4.44.0205291930290.14819-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

I just tried to install 2.4.19-pre9 on my DEC Alpha XL-300, compile went
without problems, but it won't boot.

(Text written down by hand)

Message from sym53c8xx (old):
|sym53c8xx: 53c810a detected
|CACHE TEST FAILED: DMA error (dstat=0xa0)
|CACHE INCORRECTLY CONFIGURED.

Message from ncr53c8xx:
| ncr53810a-0: CACHE TEST FAILED
| stat=801ef414, pc=801ef414, end=801ef440
| CACHE INCORRECTLY CONFIGURED.

sym53c8xx-2 aborts with a similar message.


Kernel 2.4.10-ac4 works without problems.

boot.msg from 2.4.10-ac4 (working):

<4>Linux version 2.4.10-ac4-ares (root@ares) (gcc version 2.95.2 19991024
(release)) #2 Thu Oct 4 20:37:42 MEST 2001
<4>Booting on Alcor variation Bret using machine vector Alcor from MILO
<4>Command line: bootdevice=sda3 bootfile=boot/vmlinuz.old root=/dev/sda3
<4>memcluster 0, usage 2, start        0, end        1
<4>memcluster 1, usage 0, start        1, end      252
<4>memcluster 2, usage 2, start      252, end      254
<4>memcluster 3, usage 0, start      254, end      256
<4>memcluster 4, usage 2, start      256, end      328
<4>memcluster 5, usage 0, start      328, end      384
<4>memcluster 6, usage 2, start      384, end      691
<4>memcluster 7, usage 0, start      691, end     8192
<4>freeing pages 1:252
<4>freeing pages 254:256
<4>freeing pages 328:384
<4>freeing pages 693:8192
<4>reserving pages 1:2
<4>pci: cia revision 1
<4>On node 0 totalpages: 8192
<4>zone(0): 8192 pages.
<4>zone(1): 0 pages.
<4>zone(2): 0 pages.
<4>Kernel command line: bootdevice=sda3 bootfile=boot/vmlinuz.old
root=/dev/sda3
<6>Using epoch = 1980
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 593.48 BogoMIPS
<4>Memory: 61336k/65536k available (1404k kernel code, 1144k reserved,
474k data, 312k init)
<4>Dentry-cache hash table entries: 8192 (order: 4, 131072 bytes)
<4>Inode-cache hash table entries: 4096 (order: 3, 65536 bytes)
<4>Mount-cache hash table entries: 1024 (order: 1, 16384 bytes)
<4>Buffer-cache hash table entries: 1024 (order: 0, 8192 bytes)
<4>Page-cache hash table entries: 8192 (order: 3, 65536 bytes)
<4>POSIX conformance testing by UNIFIX
<4>pci: passed tb register update test
<4>pci: passed sg loopback i/o read test
<4>pci: passed tbia test
<4>pci: passed pte write cache snoop test
<4>pci: failed valid tag invalid pte reload test (mcheck; workaround
available)
<4>pci: passed pci machine check test
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd v1.8
<5>VFS: Diskquotas version dquot_6.5.0 initialized
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<4>block: queued sectors max/low 40501kB/13500kB, 128 slots per queue
<6>SCSI subsystem driver Revision: 1.00
<6>sym53c8xx: at PCI bus 0, device 9, function 0
<6>sym53c8xx: 53c810a detected
<6>sym53c810a-0: rev 0x11 on pci bus 0 device 9 function 0 irq 28
<6>sym53c810a-0: ID 7, Fast-10, Parity Checking
<6>scsi0 : sym53c8xx-1.7.3c-20010512
<4>  Vendor: IBM       Model: DCAS-34330        Rev: S63A
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>  Vendor: TOSHIBA   Model: CD-ROM XM-5401TA  Rev: 3605
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<6>ncr53c8xx: at PCI bus 0, device 9, function 0
<4>ncr53c8xx: IO region 0x9000[0..127] is in use
<4>Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
<6>sym53c810a-0-<4,*>: FAST-10 SCSI 10.0 MB/s (100.0 ns, offset 8)
<4>SCSI device sda: 8250001 512-byte hdwr sectors (4224 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3 sda4
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 512 buckets, 8Kbytes
<4>TCP: Hash tables configured (established 4096 bind 4096)
<6>Linux IP multicast router 0.06 plus PIM-SM
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>Freeing unused kernel memory: 312k freed


More infos available on request.

c'ya
sven

ps: Is there a site with more information about linux on alpha?
    http://www.alphalinux.org/ seems to be down.

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

