Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbRGLLUY>; Thu, 12 Jul 2001 07:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267475AbRGLLUP>; Thu, 12 Jul 2001 07:20:15 -0400
Received: from ns1.tu-graz.ac.at ([129.27.2.3]:19864 "EHLO ns1.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S267473AbRGLLT6>;
	Thu, 12 Jul 2001 07:19:58 -0400
Date: Thu, 12 Jul 2001 13:19:55 +0200 (CEST)
From: Reinhard Wolfgang Kreiner <rkreiner@sbox.tugraz.at>
X-X-Sender: <rkreiner@pluto.tu-graz.ac.at>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] SuSE-Kernel 2.4.6 reiserfs, namei.c:343
Message-ID: <Pine.LNX.4.33.0107121305010.17705-100000@pluto.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We are using LVM, RAID5 Controller Compaq-smart-driver
and Reiserfs


Kernel 2.4.6 downloaded from SuSE (SuSE7.2),
nothing compiled as module

Following Error occured on our Server:


Jul 10 08:26:12 lolx02 kernel: is_tree_node: node level 34814 does not
match to the expected one 1
Jul 10 08:26:12 lolx02 kernel: vs-5150: search_by_key: invalid format
found in block 9368. Fsck?
Jul 10 08:26:12 lolx02 kernel: kernel BUG at namei.c:343!
Jul 10 08:26:12 lolx02 kernel: invalid operand: 0000
Jul 10 08:26:12 lolx02 kernel: CPU:    0
Jul 10 08:26:12 lolx02 kernel: EIP:
0010:[reiserfs_find_entry+136/324]
Jul 10 08:26:12 lolx02 kernel: EFLAGS: 00010282
Jul 10 08:26:12 lolx02 kernel: eax: 0000001b   ebx: c8c37e54   ecx:
00000001   edx: c02b50e4
Jul 10 08:26:12 lolx02 kernel: esi: c0272d10   edi: c8c37ed8   ebp:
c8c37e6c   esp: c8c37e3c
Jul 10 08:26:12 lolx02 kernel: ds: 0018   es: 0018   ss: 0018
Jul 10 08:26:12 lolx02 kernel: Process opbs (pid: 1214,
stackpage=c8c37000)
Jul 10 08:26:12 lolx02 kernel: Stack: c0272bb1 c0272c25 00000157
00000000 c0272d10 c8c37e98 00000922 00000a79
Jul 10 08:26:12 lolx02 kernel:        2225d6ff 000001f4 00000000
00000003 cfdf8940 c0190200 d7702080 cfdf89a0
Jul 10 08:26:12 lolx02 kernel:        0000000d c8c37e98 c8c37ed8
fffffff4 d7702080 cfdf8940 d7633be0 00000001
Jul 10 08:26:12 lolx02 kernel: Call Trace: [reiserfs_lookup+108/196]
[d_alloc+27/384] [real_lookup+83/196] [path_walk+1385/1928]
[__user_walk+60/88] [sys_stat64+22/120] [system_call+51/56]
Jul 10 08:26:12 lolx02 kernel:
Jul 10 08:26:12 lolx02 kernel: Code: 0f 0b 83 c4 0c 8d 76 00 8b 4d 10 51
8b 45 0c 50 57 8d 55 e8

------------------------------------------------------------------------

CPUINFO:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 930.434
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1854.66

------------------------------------------------------------------------------

PCIINFO:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: ServerWorks CNB20LE Host Bridge (rev 5).
      Master Capable.  Latency=64.
  Bus  0, device   0, function  1:
    Host bridge: ServerWorks CNB20LE Host Bridge (#2) (rev 5).
      Master Capable.  Latency=64.
  Bus  0, device   1, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1510 (rev 2).
      IRQ 10.
      Master Capable.  Latency=255.  Min Gnt=30.Max Lat=8.
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0xc6dffc00 [0xc6dfffff].
      Non-prefetchable 32 bit memory at 0xc6dfe000 [0xc6dfefff].
  Bus  0, device   1, function  1:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1510 (#2) (rev 2).
      IRQ 11.
      Master Capable.  Latency=255.  Min Gnt=30.Max Lat=8.
      I/O at 0x2400 [0x24ff].
      Non-prefetchable 32 bit memory at 0xc6dfdc00 [0xc6dfdfff].
      Non-prefetchable 32 bit memory at 0xc6dfc000 [0xc6dfcfff].
  Bus  0, device   2, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 8).
      IRQ 15.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xc6dfb000 [0xc6dfbfff].
      I/O at 0x2800 [0x283f].
      Non-prefetchable 32 bit memory at 0xc6c00000 [0xc6cfffff].
  Bus  0, device   3, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 122).
      Master Capable.  No bursts.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xc4000000 [0xc4ffffff].
      I/O at 0x2c00 [0x2cff].
      Non-prefetchable 32 bit memory at 0xc6bff000 [0xc6bfffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (#2) (rev 122).
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xc5000000 [0xc5ffffff].
      I/O at 0x4000 [0x40ff].
      Non-prefetchable 32 bit memory at 0xc6eff000 [0xc6efffff].
  Bus  0, device   4, function  0:
    System peripheral: Compaq Computer Corporation Advanced System Management Controller (rev 0).
      I/O at 0x1800 [0x18ff].
      Non-prefetchable 32 bit memory at 0xc6bfef00 [0xc6bfefff].
  Bus  0, device   5, function  0:
    PCI bridge: Intel Corporation 80960RP [i960 RP Microprocessor/Bridge] (rev 5).
      Master Capable.  Latency=64.  Min Gnt=13.
  Bus  0, device   5, function  1:
    Memory controller: Intel Corporation 80960RP [i960RP Microprocessor] (rev 5).
      IRQ 15.
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xc3fc0000 [0xc3ffffff].
  Bus  0, device  15, function  0:
    ISA bridge: ServerWorks OSB4 South Bridge (rev 81).
  Bus  0, device  15, function  1:
    IDE interface: ServerWorks OSB4 IDE Controller (rev 0).
      Master Capable.  Latency=64.
      I/O at 0x3000 [0x300f].
  Bus  3, device   3, function  0:
    RAID bus controller: Digital Equipment Corporation DECchip 21554 (rev 1).
      IRQ 5.
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xc6fff000 [0xc6ffffff].
      I/O at 0x5000 [0x50ff].


--------------------------------------------------------------------

ida0:  Compaq Smart Array 431 Controller
       Board ID: 0x40580e11
       Firmware Revision: 1.02
       Controller Sig: 0xa23e3705
       Memory Address: 0xd8800000
       I/O Port: 0xc6fff000
       IRQ: 5
       Logical drives: 2
       Physical drives: 6

       Current Q depth: 0
       Max Q depth since init: 128

Logical Drive Info:
ida/c0d0: blksz=512 nr_blks=17756160
ida/c0d1: blksz=512 nr_blks=213367680
nr_allocs = 2627208
nr_frees = 2627208

---------------------------------------------------------------
#fdisk /dev/ida/c0d1

The number of cylinders for this disk is set to 26148.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/ida/c0d1: 255 heads, 32 sectors, 26148 cylinders
Units = cylinders of 8160 * 512 bytes

         Device Boot    Start       End    Blocks   Id  System
/dev/ida/c0d1p1             1     26148 106683824   8e  Linux LVM


--------------------------------------------------------------------


After changing reiserfs to ext2 following problem occured :



Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1472119408,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=2021490192,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1589852080,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1589852080,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1589852080,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1589852080,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=740752976,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=740752976,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=2118205324,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=2118205324,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=2118205324,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=2118205324,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=155164112,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=155164112,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=155164112,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=155164112,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1604310440,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1604310440,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=534685688,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=534685688,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=282583832,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=494818656,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=401053180,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=985613700,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=737508096,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=1063890908,
limit=10485760
Jul 10 15:50:25 lolx02 kernel: attempt to access beyond end of device
Jul 10 15:50:25 lolx02 kernel: 3a:08: rw=0, want=2008743372,
limit=10485760

-----------------------------------------------------------------------
possible HDD problem?


if u need more information, i try to get it from our server-admin

any idea or solution?!?

thanks
Reinhard



