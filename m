Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbUK0DZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUK0DZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUKZTgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:36:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262404AbUKZTWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:22:40 -0500
Message-ID: <41A69247.4080308@treshna.com>
Date: Fri, 26 Nov 2004 15:17:43 +1300
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux@syskonnect.de
Subject: Alpha problem with networking support with sk98lin -> oops on bringing
 up interfaces
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a alpha box which I can't get nerworking working with my sk98lin 
cards. I had other weird problems with trying a few other network cards 
so it might not be just the sk98lin one. The onboard network card works 
fine on 2.6.9 with a customised build, sk98lin fails every time.

Card types: D-Link DGE-530T cards. I've tried different cards of same 
model so i dont think its a hardware fault.

Kernels tried:
2.6.6
2.6.8.1
2.6.9

Orginal output from one oops with 2.6.8:

Linux version 2.6.8 (root@azrael) (gcc version 3.3.4 (Debian 
1:3.3.4-13)) #2 Wed Nov 17 23:25:11 NZDT 2004
Booting GENERIC on Nautilus using machine vector Nautilus from SRM
Major Options: LEGACY_START
Command line: ro root=/dev/hda3
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end    65459
memcluster 2, usage 1, start    65459, end    65536
freeing pages 256:384
freeing pages 841:65459
reserving pages 841:842
8192K Bcache detected; load hit latency 18 cycles, load miss latency 159 
cycles
Iron stat_cmd 22100006
Iron ECC f00
On node 0 totalpages: 65459
  DMA zone: 2048 pages, LIFO batch:1
  Normal zone: 63411 pages, LIFO batch:8
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: ro root=/dev/hda3
PID hash table entries: 2048 (order 11: 32768 bytes)
HWRPB cycle frequency bogus.  Estimated 796417845 Hz
Using epoch = 2000
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 512328k/523672k available (2007k kernel code, 8920k reserved, 
566k data, 288k init)
Calibrating delay loop... 1586.36 BogoMIPS
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
NET: Registered protocol family 16
EISA bus registered
pci: enabling save/restore of SRM state
PCI: Bus 1, bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fb000000-fbffffff
  PREFETCH window: fc000000-feffffff
Linux Plug and Play Support v0.97 (c) Adam Belay
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 36 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS35 at I/O 0x8028 (irq = 255) is a 8250
ttyS2 at I/O 0x8040 (irq = 255) is a 8250
ttyS3 at I/O 0x8050 (irq = 255) is a 8250
ttyS4 at I/O 0x8060 (irq = 255) is a 8250
ttyS5 at I/O 0x8070 (irq = 255) is a 8250
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8c80-0x8c87, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8c88-0x8c8f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG SP0802N, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG (OEM)CD-ROM CRD-8521B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, 
UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p2 p3
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 288k freed
Adding 1582384k swap on /dev/hda2.  Priority:-1 extents:1
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12
inserting floppy driver for 2.6.8
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
input: PC Speaker
input: PS/2 Generic Mouse on isa0060/serio1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ip_tables: (C) 2000-2002 Netfilter core team
Capability LSM initialized
NET: Registered protocol family 10
Disabled Privacy Extensions on device fffffc00006132e8(lo)
IPv6 over IPv4 tunneling driver
sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
eth0: DGE-530T Gigabit Ethernet Adapter
      PrefPort:A  RlmtMode:Check Link State
Unable to handle kernel paging request at virtual address fc00539480000000
ifconfig(695): Oops -1
pc = [<fc00539480000000>]  ra = [<fffffffc005380d0>]  ps = 0007    Not 
tainted
v0 = fffffc001cfa2680  t0 = fffffffc00551425  t1 = 00000000000056d8
t2 = fffffffc005513fd  t3 = 0000000000000001  t4 = 0000000000000000
t5 = fffffc001cfa7d58  t6 = 0000000000000007  t7 = fffffc001c0a4000
s0 = fffffc001cfa0000  s1 = fffffc001cfa2680  s2 = 0000000000000000
s3 = 0000000000000000  s4 = 0000000000000002  s5 = 0000000000000001
s6 = fffffc001c0a7cc8
a0 = fffffc001cfa0000  a1 = fffffd00ff060000  a2 = 0000000000000000
a3 = 0000000002000000  a4 = fffffc001cfa2680  a5 = fffffc001c0a79cc
t8 = 000000000000000f  t9 = fffffc0000402ba0  t10= 0000000000000020
t11= 00000000000004e2  pv = fc00539480000000  at = 00000000419b4404
gp = fffffffc00559a98  sp = fffffc001c0a7968
Trace:
[<fffffc000039f574>] load_elf_interp+0x264/0x300
[<fffffc000048da38>] rtnetlink_fill_ifinfo+0x3a8/0x518
[<fffffc000048ded4>] rtmsg_ifinfo+0x68/0xf4
[<fffffc000048e518>] rtnetlink_event+0x70/0xa4
[<fffffc000033bdcc>] notifier_call_chain+0x44/0x80
[<fffffc000048423c>] dev_open+0x160/0x180
[<fffffc0000485f4c>] dev_change_flags+0x84/0x1bc
[<fffffc00004d7404>] devinet_ioctl+0x33c/0x87c
[<fffffc00004da080>] inet_ioctl+0xb0/0x110
[<fffffc0000479ce8>] sock_ioctl+0x3c4/0x3f4
[<fffffc0000387464>] sys_ioctl+0x2fc/0x340
[<fffffc0000314db4>] entSys+0xa4/0xc0

Code:


Opps with 2.6.9

Unable to handle kernel paging request at virtual address fc0048d880000000
ifconfig(1193): Oops -1
pc = [<fc0048d880000000>]  ra = [<fffffffc0048c4d0>]  ps = 0007    Not 
tainted
pc is at 0xfc0048d880000000
ra is at SkPnmiGetStruct+0x3a0/0x570 [sk98lin]
v0 = fffffc001caf2680  t0 = 00000000000056d8  t1 = 0000000000000001
t2 = 0000000000000001  t3 = fffffc001caf7d40  t4 = fffffc001caf7d58
t5 = fffffc001caf7d58  t6 = fffffc001caf7d40  t7 = fffffc001ca20000
s0 = fffffc001caf0000  s1 = fffffc001caf2680  s2 = 0000000000000000
s3 = fffffc001ca23c68  s4 = fffffd00ff060000  s5 = fffffffc004a27ad
s6 = 0000000000000000
a0 = fffffc001caf0000  a1 = fffffd00ff060000  a2 = 0000000000000000
a3 = 0000000002000000  a4 = fffffc001caf2680  a5 = fffffc001ca2396c
t8 = 000000000000000f  t9 = fffffc00003f1ff0  t10= 0000000000000020
t11= 00000000000004e2  pv = fc0048d880000000  at = 0000000041a686fa
gp = fffffffc004a94d0  sp = fffffc001ca23908
Trace:
[<fffffc000048f314>] rtnetlink_fill_ifinfo+0x474/0x5e0
[<fffffc000048f9b8>] rtmsg_ifinfo+0x68/0x100
[<fffffc000048fd34>] rtnetlink_event+0x44/0x90
[<fffffc00003382d4>] notifier_call_chain+0x54/0x90
[<fffffc0000484278>] dev_open+0xe8/0x100
[<fffffc00004860b8>] dev_change_flags+0x78/0x1a0
[<fffffc00004ce0d4>] devinet_ioctl+0x334/0x700
[<fffffc00004d0d80>] inet_ioctl+0xb0/0x120
[<fffffc0000478a64>] sock_ioctl+0x1a4/0x430
[<fffffc0000387488>] sys_ioctl+0x118/0x340
[<fffffc0000312c84>] entSys+0xa4/0xc0

Code:


ksyoops output:
ksymoops 2.4.9 on alpha 2.6.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9/ (default)
     -m /boot/System.map-2.6.9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address fc0048d880000000
ifconfig(1193): Oops -1
pc = [<fc0048d880000000>]  ra = [<fffffffc0048c4d0>]  ps = 0007    Not 
tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc001caf2680  t0 = 00000000000056d8  t1 = 0000000000000001
t2 = 0000000000000001  t3 = fffffc001caf7d40  t4 = fffffc001caf7d58
t5 = fffffc001caf7d58  t6 = fffffc001caf7d40  t7 = fffffc001ca20000
s0 = fffffc001caf0000  s1 = fffffc001caf2680  s2 = 0000000000000000
s3 = fffffc001ca23c68  s4 = fffffd00ff060000  s5 = fffffffc004a27ad
s6 = 0000000000000000
a0 = fffffc001caf0000  a1 = fffffd00ff060000  a2 = 0000000000000000
a3 = 0000000002000000  a4 = fffffc001caf2680  a5 = fffffc001ca2396c
t8 = 000000000000000f  t9 = fffffc00003f1ff0  t10= 0000000000000020
t11= 00000000000004e2  pv = fc0048d880000000  at = 0000000041a686fa
gp = fffffffc004a94d0  sp = fffffc001ca23908
Trace:
[<fffffc000048f314>] rtnetlink_fill_ifinfo+0x474/0x5e0
[<fffffc000048f9b8>] rtmsg_ifinfo+0x68/0x100
[<fffffc000048fd34>] rtnetlink_event+0x44/0x90
[<fffffc00003382d4>] notifier_call_chain+0x54/0x90
[<fffffc0000484278>] dev_open+0xe8/0x100
[<fffffc00004860b8>] dev_change_flags+0x78/0x1a0
[<fffffc00004ce0d4>] devinet_ioctl+0x334/0x700
[<fffffc00004d0d80>] inet_ioctl+0xb0/0x120
[<fffffc0000478a64>] sock_ioctl+0x1a4/0x430
[<fffffc0000387488>] sys_ioctl+0x118/0x340
[<fffffc0000312c84>] entSys+0xa4/0xc0
Warning (Oops_read): Code line not seen, dumping what data is available


 >>PC;  fc0048d880000000 Before first symbol   <=====

Trace; fffffc000048f314 <rtnetlink_fill_ifinfo+474/5e0>
Trace; fffffc000048f9b8 <rtmsg_ifinfo+68/100>
Trace; fffffc000048fd34 <rtnetlink_event+44/90>
Trace; fffffc00003382d4 <notifier_call_chain+54/90>
Trace; fffffc0000484278 <dev_open+e8/100>
Trace; fffffc00004860b8 <dev_change_flags+78/1a0>
Trace; fffffc00004ce0d4 <devinet_ioctl+334/700>
Trace; fffffc00004d0d80 <inet_ioctl+b0/120>
Trace; fffffc0000478a64 <sock_ioctl+1a4/430>
Trace; fffffc0000387488 <sys_ioctl+118/340>
Trace; fffffc0000312c84 <entSys+a4/c0>


2 warnings and 1 error issued.  Results may not be reliable.

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller (rev 19).
      Master Capable.  Latency=255.
      Prefetchable 32 bit memory at 0xff064000 [0xff064fff].
      I/O at 0x8c90 [0x8c93].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP 
Bridge (rev 0).
      Master Capable.  Latency=255.  Min Gnt=12.
  Bus  0, device   3, function  0:
    Modem: ALi Corporation M5457 AC'97 Modem Controller (rev 0).
      IRQ 255.
      Master Capable.  Latency=255.
      Non-prefetchable 32 bit memory at 0xff065000 [0xff065fff].
      I/O at 0x8000 [0x80ff].
  Bus  0, device   6, function  0:
    Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 2).
      IRQ 10.
      Master Capable.  Latency=240.  Min Gnt=2.Max Lat=24.
      I/O at 0x8400 [0x84ff].
      Non-prefetchable 32 bit memory at 0xff066000 [0xff066fff].
  Bus  0, device   7, function  0:
    ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] 
(rev 0).
  Bus  0, device   9, function  0:
    Ethernet controller: D-Link System Inc Gigabit Ethernet Adapter (rev 
17).
      IRQ 9.
      Master Capable.  Latency=255.  Min Gnt=23.Max Lat=31.
      Non-prefetchable 32 bit memory at 0xff060000 [0xff063fff].
      I/O at 0x8800 [0x88ff].
  Bus  0, device  11, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21142/43 
(rev 65).
      IRQ 11.
      Master Capable.  Latency=255.  Min Gnt=20.Max Lat=40.
      I/O at 0x8c00 [0x8c7f].
      Non-prefetchable 32 bit memory at 0xff068000 [0xff0683ff].
  Bus  0, device  16, function  0:
    IDE interface: ALi Corporation M5229 IDE (rev 196).
      IRQ 15.
      Master Capable.  Latency=255.  Min Gnt=2.Max Lat=4.
      I/O at 0x8c80 [0x8c8f].
  Bus  0, device  17, function  0:
    Non-VGA unclassified device: ALi Corporation M7101 Power Management 
Controller [PMU] (rev 0).
  Bus  0, device  20, function  0:
    USB Controller: ALi Corporation USB 1.1 Controller (rev 3).
      IRQ 9.
      Master Capable.  Latency=248.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xff067000 [0xff067fff].
  Bus  1, device   5, function  0:
    VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 
Model 64/Model 64 Pro] (rev 21).
      IRQ 10.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xfb000000 [0xfbffffff].
      Prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].



