Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSBAJeO>; Fri, 1 Feb 2002 04:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291641AbSBAJeE>; Fri, 1 Feb 2002 04:34:04 -0500
Received: from web13302.mail.yahoo.com ([216.136.175.38]:57361 "HELO
	web13302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S291640AbSBAJdw>; Fri, 1 Feb 2002 04:33:52 -0500
Message-ID: <20020201093348.520.qmail@web13302.mail.yahoo.com>
Date: Fri, 1 Feb 2002 01:33:48 -0800 (PST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: RE: false positives on disk change checks
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> wrote:

> Andre, looks like setup above gives false positives on disk change 
> check...

I don't know the original posters problem, but I suspect I see something
similar. On a to be embedded system with a Geode (Cyrix) CPU and with a
ATA compatible CompactFlash drive I get the following messages on bootup:

invalidate: busy buffer
VFS: busy inodes on changed media.

This seems to happen while the system tries to remount the root fs rw.

My Boot messages (plain Marcello 2.4.17):

LILO 21.7 boot:
Loading linux.........
Linux version 2.4.17 (jpo@crt-kref) (gcc version 2.95.3 20010315 (SuSE))
#3 Mit
Jan 30 18:52:57 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007e80000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32384
zone(0): 4096 pages.
zone(1): 28288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux root=1641 console=ttyS0,38400
console=tty0Initializing CPU#0
Working around Cyrix MediaGX virtual DMA bugs.
Console: colour VGA+ 80x25
Calibrating delay loop... 95.84 BogoMIPS
Memory: 125812k/129536k available (746k kernel code, 3340k reserved, 161k
data,
68k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Working around Cyrix MediaGX virtual DMA bugs.
CPU: Cyrix Geode(TM) Integrated Processor by National Semi stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfae70, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router NatSemi [1078/0100] at 00:12.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
CS5530: IDE controller on PCI bus 00 dev 92
CS5530: chipset revision 0
CS5530: not 100% native mode: will probe irqs later
hdd: Key Technology Corp. ATA-KUO WizardPlus, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdd: 251904 sectors (129 MB) w/0KiB Cache, CHS=984/16/16
Partition check:
 hdd:spurious 8259A interrupt: IRQ7.
 hdd1 hdd2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.1
8139too Fast Ethernet driver 0.9.22
PCI: Found IRQ 11 for device 00:0c.0
eth0: RealTek RTL8139 Fast Ethernet at 0xc8800000, 00:e0:4c:71:05:92, IRQ
11
PCI: Found IRQ 10 for device 00:0d.0
eth1: RealTek RTL8139 Fast Ethernet at 0xc8802000, 00:e0:4c:71:05:91, IRQ
10
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 hdd: hdd1 hdd2
 hdd: hdd1 hdd2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 68k freed
invalidate: busy buffer
VFS: busy inodes on changed media.

Regards
  Joerg

=====
-- 
Regards
       Joerg


__________________________________________________
Do You Yahoo!?
Great stuff seeking new owners in Yahoo! Auctions! 
http://auctions.yahoo.com
