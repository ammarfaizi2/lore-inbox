Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbRLaSUD>; Mon, 31 Dec 2001 13:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287584AbRLaSTr>; Mon, 31 Dec 2001 13:19:47 -0500
Received: from smtp02.web.de ([217.72.192.151]:16644 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S287592AbRLaSTb>;
	Mon, 31 Dec 2001 13:19:31 -0500
Message-ID: <3C30A9F0.3070603@web.de>
Date: Mon, 31 Dec 2001 19:09:52 +0100
From: Klaus Zerwes <kzerwes@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug ?
Content-Type: multipart/mixed;
 boundary="------------020905020709080509070307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020905020709080509070307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

First: my english is realy bad - sorry

My PC hangs sporadicaly (every 2 weeks) after heavy Network traffic.
I tried to work around the problem by changing the NIC (dmfe > 
realtek, using new driver 8139too), but it din't help.
Today i had the luck ( :-( ) that the syslog-console was activ, so 
that I could get the messages (otherwise the PC hangs completly, and 
its no more longer possible to change the console)
The PC akts as a small server.
Main running services:
Kernel-NFS
Samba 2.2.1
mysql
sshd: OpenSSH_2.9.9p2, SSH protocols 1.5/2.0, OpenSSL 0x0090602f
apache w/ php
ip-filter
squid
Hardware:
lspci -v says:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
         Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin 
V/V+ AGP System Controller
         Flags: bus master, slow devsel, latency 32
         Memory at da000000 (32-bit, non-prefetchable) [size=16M]
         Capabilities: [b0] AGP version 1.0

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) 
(prog-if 00 [Normal decode])
         Flags: bus master, slow devsel, latency 32
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: d8000000-d9ffffff
         Prefetchable memory behind bridge: db000000-dbffffff

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA 
Bridge [Aladdin IV] (rev c3)
         Flags: bus master, medium devsel, latency 0

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) 
(prog-if fa)
         Flags: bus master, medium devsel, latency 32, IRQ 5
         I/O ports at f000 [size=16]

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at e000 [size=256]
         Memory at dd000000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at dc000000 [disabled] [size=64K]

00:14.0 Network controller: AVM Audiovisuelles MKTG & Computer System 
GmbH A1 ISDN [Fritz] (rev 02)
         Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH 
FRITZ!Card ISDN Controller
         Flags: medium devsel, IRQ 11
         Memory at dd002000 (32-bit, non-prefetchable) [size=32]
         I/O ports at e400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 
AGP (rev 7a) (prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc: Unknown device 0084
         Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
         Memory at db000000 (32-bit, prefetchable) [size=16M]
         I/O ports at d000 [size=256]
         Memory at d9000000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [5c] Power Management version 1



and now the errormessage:
invalid opperand: 0000
CPU: 0
EIP: 0010:[<c010a123>]
------ inserted
(the only simmilar entry in System.map:c010a120 t IRQ0x00_interrupt)
------ continue
EFLAGS: 00010046
eax: d4ac5428	ebx:00000014	ecx:00000054	edx:14c42814
esi: 0402d7c0	edi:26dd33a3	ebp:04040101    esp:c2f23fe8
ds 002b		es 002b		ss 0018
Process sshd (pid 1407, stackpage=c2f23000)
Stack: ffffff00 08078480 00000023
        00000206 bffff236 0000002b
Call Trace:

Code: ff ff eb d9 89 f6 8d bc 27 00 00 00 00 68 01 ff ff ff eb c9

teh error ocured while i was doing a backup via ssh & tar + gzip
( something like:
ssh 192.168.0.1 tar -cSp --numeric-owner -f - /xport/netdata | gzip> \ 
/var/backup/hdd4/filename.tgz)
but as I said simillar errors ocure not only while running ssh.
Same error i had with earlier Kernelversions (2.4.9, 2.4.8), thats wy 
i use a out-of-the-box-kernel of a Distribution (SuSE).
If this error seems to result out of a hardware error, a reply would 
be verry nice.

I send you the output of dmesg as a txtfile.
I'w downloaded today aktual Kernel and try it with 2.4.17.

Thank you all for doing such a good work on this nice OS.
I work since 3 years with Linux - and I enjoi it every day.

A happy new year from Berlin
Klaus

-- 
live free or die :: linux

--------------020905020709080509070307
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.4.10-4GB (root@Pentium.suse.de) (gcc version 2.95.3 20010315 (SuSE)) #1 Tue Sep 25 12:33:54 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=server ro root=302 BOOT_FILE=/boot/vmlinuz
Initializing CPU#0
Detected 501.141 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 126416k/131008k available (1289k kernel code, 4204k reserved, 381k data, 124k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
Enabling new style K6 write allocation for 127 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb2a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: Assigned IRQ 5 for device 00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM BIGFOOT TS12.7A, ATA DISK drive
hdb: FX810S, ATAPI CD/DVD-ROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: ST320423A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 25075008 sectors (12838 MB) w/418KiB Cache, CHS=1560/255/63, UDMA(33)
hdc: 40011300 sectors (20486 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(33)
hdb: ATAPI 8X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 hda3
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding Swap: 249944k swap-space (priority -1)
Adding Swap: 128480k swap-space (priority -2)
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.114.6.14/1.94.6.7/1.140.6.8/1.85.6.6/1.21.6.1/1.5.6.3 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.4
HiSax: Layer2 Revision 2.25.6.3
HiSax: TeiMgr Revision 2.17.6.2
HiSax: Layer3 Revision 2.17.6.4
HiSax: LinkLayer Revision 2.51.6.5
HiSax: Approval certification valid
HiSax: Approved with ELSA Microlink PCI cards
HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
HiSax: Approved with Sedlbauer Speedfax + cards
HiSax: Approved with HFC-S PCI A based cards
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: AVM PCI driver Rev. 1.22.6.5
PCI: Found IRQ 11 for device 00:14.0
AVM PCI: stat 0x20a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:11 base:0xE400
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 11 count 0
AVM Fritz PnP/PCI: IRQ 11 count 5
HiSax: DSS1 Rev. 2.30.6.1
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
HiSax: debugging flags card 1 set to 4
isdn: Verbose-Level is 3
ippp, open, slot: 0, minor: 0, state: 0000
ippp_ccp: allocated reset data structure c5427000
8139too Fast Ethernet driver 0.9.18a
PCI: Found IRQ 10 for device 00:10.0
eth0: RealTek RTL8139 Fast Ethernet at 0xc8849000, 00:50:fc:2e:bc:5c, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ip_tables: (c)2000 Netfilter core team
ip_conntrack (1023 buckets, 8184 max)
eth0: no IPv6 routers present
OPEN: 192.168.1.99 -> 145.253.2.11 ICMP
ippp0: dialing 1 0192071...
isdn_net: ippp0 connected
nfsd: last server has exited
nfsd: unexporting all filesystems

--------------020905020709080509070307--

