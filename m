Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSFQEyi>; Mon, 17 Jun 2002 00:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSFQEyh>; Mon, 17 Jun 2002 00:54:37 -0400
Received: from web21001.mail.yahoo.com ([216.136.227.55]:15458 "HELO
	web21001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316712AbSFQEyf>; Mon, 17 Jun 2002 00:54:35 -0400
Message-ID: <20020617045436.3078.qmail@web21001.mail.yahoo.com>
Date: Sun, 16 Jun 2002 21:54:36 -0700 (PDT)
From: kk maddowx <kk_maddox2000@yahoo.com>
Subject: 2.4.18 kernel panics before and after boot
To: linux-kernel@vger.kernel.org
Cc: kk_maddox2000@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running kernel version 2.4.18 and have
experienced server kernel panics. Sometimes this
occurs at boot and other times the box boots but will
invariably panic at some point. Ksymoops reports the
following from my oops file:


1>Unable to handle kernel NULL pointer dereference at
v
00000400
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000400>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: c02e4e40   ecx: c8816000   edx:
00000004
esi: 00000004   edi: 0000001b   ebp: 000003d9   esp:
c1263f28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1263000)
Stack: c11db840 c0127b63 c02e4e40 0181987c c1262000
0000005e 000001d0 c02897e8
       c0300320 c12f51e0 c1207180 00000000 00000020
000001d0 00000006 00002e94
       c0127cd6 00000006 00000010 c02897e8 00000006
000001d0 c02897e8 00000000
Call Trace: [<c0127b63>] [<c0127cd6>] [<c0127d40>]
[<c0127dd4>] [<c0127e36>]
   [<c0127f51>] [<c0127eb0>] [<c010552b>]
Code:  Bad EIP value.

>>EIP; 00000400 Before first symbol   <=====
Trace; c0127b63 <shrink_cache+2b3/2f0>
Trace; c0127cd6 <shrink_caches+56/90>
Trace; c0127d40 <try_to_free_pages+30/50>
Trace; c0127dd4 <kswapd_balance_pgdat+44/90>
Trace; c0127e36 <kswapd_balance+16/30>
Trace; c0127f51 <kswapd+a1/c0>
Trace; c0127eb0 <kswapd+0/c0>
Trace; c010552b <kernel_thread+2b/40>

Distro: Redhat 7.0
kernel version: 2.4.18
compiler: gcc version 2.96 20000731
cpu: 

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 0
cpu MHz         : 333.522
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep
mmx 3dnow
bogomips        : 665.19

modules: 3com Boomerang 3c59x, adaptec aic7xxx.

The scsi card installed only contains a tape drive.
The disks are all ide using ext2. More relevant
hardware details is as follows:

LI15X3: IDE controller on PCI bus 00 dev 78
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings:
hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings:
hdc:pio, hdd:pio
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
hda: WDC AC313000R, ATA DISK drive
hdb: CREATIVEDVD-ROM DVD2240E 12/24/97, ATAPI CDROM
drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: WDC AC313000R, 12416MB w/512kB Cache,
CHS=1582/255/63, (U)DMA
hdb: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

I did a google search and found similar posts but no
replies as to possible causes. I am providing this
post in the hopes of providing a commonality or median
as to the source of these panics with 2.4.18. Please
let me know if any other info is helpful. I would
appreciate any feedback.

TIA
kk









__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
