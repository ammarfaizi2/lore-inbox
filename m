Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSHSFbT>; Mon, 19 Aug 2002 01:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSHSFbT>; Mon, 19 Aug 2002 01:31:19 -0400
Received: from webmail22.rediffmail.com ([203.199.83.144]:51641 "HELO
	webmail22.rediffmail.com") by vger.kernel.org with SMTP
	id <S318161AbSHSFbR>; Mon, 19 Aug 2002 01:31:17 -0400
Date: 19 Aug 2002 05:33:45 -0000
Message-ID: <20020819053345.25908.qmail@webmail22.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Booting Linux using initrd
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I am trying to boot a Real Time Linux on a MIPS RC32334 based
board using initrd feature and i am trying to mount the RAMDISK as 
my root file system. The boot sequence is not successful. I
get some errors. Please find in this mail the log of the Kernel.
Also find the information of the ramdisk.o that I have 
integrated
with the kernel. I will be grateful if you can spend a little of
your precious time in helping me fix the problem.

Kernel version that i am using is 2.4.5-pre1.

Sorry for troubling you.

Thanks in advance,
Nanda

--------------------------------------------------
Information of the Ramdisk.o
----------------------------
Filesystem label=embedix
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
32784 inodes, 48000 blocks
0 blocks (0.00%) reserved for the super user
First data block=1
6 block groups
8192 blocks per group, 8192 fragments per group
5464 inodes per group
Superblock backups stored on blocks:
     8193, 24577, 40961

Writing inode tables: 0/61/62/63/64/65/6 done

Writing superblocks and filesystem accounting information: done
--------------------------------------------------

Kernel Log :
------------

ttyS00 at iomem 0xb8000800 (irq = 0) is a 16550A
ttyS00 at iomem 0xb8000820 (irq = 0) is a 16550A
Loading RC323xx MMU routines.
CPU revision is: 00001800
Primary instruction cache 8kb, linesize 16 bytes (2 ways)
Primary data cache 2kb, linesize 16 bytes (2 ways)
Number of TLB entries 16.
Linux version 2.4.5-pre1 (root@brg2) (gcc version 2.95.3 
19991030
(prerelease))
#22 Sun Aug 18 18:57:44 UTC 2002
Index:  0 pgmask=01ffe000 va=e0000000 asid=00000000  
[pa=40000000
c=2 d=1 v=1 g=
1]  [pa=41000000 c=2 d=1 v=1 g=1]

idt_setup: initrd_start=80351d00 end=805937c0
Determined physical RAM map:
   memory: 801ffc00 @ 80000400 (usable)
   memory: 01a36940 @ 005c96c0 (usable)
Initial ramdisk at: 0x80351d00 (2366144 bytes)
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line:
calculating r4koff... 000b71b0(750000)
CPU frequency 150.00 MHz
Calibrating delay loop... 149.50 BogoMIPS
Memory: 26288k/26840k available (1196k kernel code, 552k 
reserved,
2391k data, 7
2k init)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
PCI: Initializing PCI
PCI: Probing PCI hardware
    got res[0:ff] for resource 2 of PCI device 10b5:0324
    got res[100:1ff] for resource 0 of PCI device 10ec:8129
PCI: Failed to allocate resource 0 for PCI device 10b5:0324
    got res[40000000:400000ff] for resource 1 of PCI device
10ec:8129
PCI enable device: (PCI device 10b5:0324)
    cmd reg 0x157
PCI enable device: (PCI device 10ec:8129)
    cmd reg 0x7
pcibios_fixup_irqs:
PCI slot 0: dev=10b5:0324 cmd=0157 stat=02a0 lsize=8 late=32 int
pin=1 line=1
PCI slot 0: dev=10b5:0324 cmd=0007 stat=02a0 lsize=0 late=64 int
pin=1 line=1 (n
ew settings)

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
block: queued sectors max/low 17384kB/5794kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024
blocksize
RAMDISK: Compressed image found at block 0
Identified 0 Blocks
Freeing initrd memory: 2310k freed
Serial driver version 5.05a (2001-03-20) with MANY_PORTS 
SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 0) is a 16550A
8139too Fast Ethernet driver 1.0.1 loaded
eth0: RealTek RTL8139CP Fast Ethernet at 0x100, 
00:50:00:11:22:33,
IRQ 255
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
request_irq: irq=255 name=eth0 dev_id=810a1800
eth0: Setting half-duplex based on auto-negotiated partner 
ability
0000.
ip_conntrack (256 buckets, 2048 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: mounting unchecked fs, running e2fsck is
recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k freed
attempt to access beyond end of device
01:00: rw=0, want=32774, limit=8192
EXT2-fs error (device ramdisk(1,0)): ext2_read_inode: unable to
read inode block
   - inode=21858, block=32773
Warning: unable to open an initial console.
attempt to access beyond end of device
01:00: rw=0, want=8200, limit=8192
EXT2-fs error (device ramdisk(1,0)): ext2_read_inode: unable to
read inode block
   - inode=5483, block=8199
attempt to access beyond end of device
01:00: rw=0, want=8198, limit=8192
EXT2-fs error (device ramdisk(1,0)): ext2_read_inode: unable to
read inode block
   - inode=5465, block=8197
attempt to access beyond end of device
01:00: rw=0, want=16390, limit=8192
EXT2-fs error (device ramdisk(1,0)): ext2_read_inode: unable to
read inode block
   - inode=10929, block=16389
Kernel panic: No init found.  Try passing init= option to
kernel.

--------------------------------------------------------

