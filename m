Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280110AbRKSSqU>; Mon, 19 Nov 2001 13:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280606AbRKSSqP>; Mon, 19 Nov 2001 13:46:15 -0500
Received: from att-lp2.wirelessmatrixcorp.com ([66.46.106.131]:39978 "HELO
	wirelessmatrixcorp.com") by vger.kernel.org with SMTP
	id <S280110AbRKSSox>; Mon, 19 Nov 2001 13:44:53 -0500
Date: Mon, 19 Nov 2001 11:44:46 -0700
From: Bill Currie <billc@wirelessmatrixcorp.com>
To: linux-kernel@vger.kernel.org
Subject: DAC960 oops
Message-ID: <20011119114446.A15561@wirelessmatrixcorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get a DS20 with a Mylex DAC960 up-and-running (boots just fine
off the ide drive:) but when I modprobe DAC960, I get the following oops
(while ksymoops is moaning about symbols etc, I got the symbols from the exact
kernel running (infact, I think it's /still/ running:)):

--8<-----
ksymoops 2.4.0 on alpha 2.4.15-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre5/ (default)
     -m /boot/System.map-2.4.15-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says fffffc0000996eb0, System.map says fffffc000088a580.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says fffffffc002cf868, /lib/modules/2.4.15-pre5/kernel/drivers/usb/usbcore.o says fffffffc002cf8e8.  Ignoring /lib/modules/2.4.15-pre5/kernel/drivers/usb/usbcore.o entry
DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: While configuring DAC960 PCI RAID Controller at
DAC960#0: PCI Bus 0 Device 9 Function 0 I/O Address 0x8080 PCI Address 0xA062000
DAC960#0: FIRMWARE VERSION VERIFICATION FAILED - DETACHING
DAC960#0: Firmware Version = '2.49-0-00'
Unable to handle kernel paging request at virtual address 0000000000000000
modprobe(1634): Oops 0
pc = [<fffffc00008f4220>]  ra = [<fffffc00008f42d8>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = ffffffffffffffea  t0 = 0000000000000000  t1 = 0000000000000300
t2 = fffffc0000b98890  t3 = fffffc000c188000  t4 = fffffc00006be110
t5 = 0000000000000061  t6 = 000000000046e254  t7 = fffffc000bbb4000
s0 = fffffc0000b48a40  s1 = fffffc0000b48a38  s2 = 0000000000000000
s3 = fffffc0000b8b2e0  s4 = fffffffc0032c488  s5 = 000000012008e970
s6 = 0000000000000006
a0 = fffffc0000b48a38  a1 = 0000000000000000  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 0000000000000000  a5 = 0000000000000000
t8 = ffffffffffffd367  t9 = fffffc000084cbd8  t10= 0000000000000a00
t11= 0000000000000040  pv = fffffc00008f42b0  at = 0000000000000000
gp = fffffc0000b7ea70  sp = fffffc000bbb7d48
Trace:fffffc00008f42d8 fffffc000082f40c fffffc0000810df0 
Code: b75e0000  b59e0020  a6290000  422905a1  f420000f  a59d1ad0 <a4310000> a4510008 

>>PC;  fffffc00008f4220 <__blk_cleanup_queue+40/d0>   <=====
Trace; fffffc00008f42d8 <blk_cleanup_queue+28/90>
Trace; fffffc000082f40c <sys_init_module+8fc/a40>
Trace; fffffc0000810df0 <entSys+a8/c0>
Code;  fffffc00008f4208 <__blk_cleanup_queue+28/d0>
0000000000000000 <_PC>:
Code;  fffffc00008f4208 <__blk_cleanup_queue+28/d0>
   0:   00 00 5e b7       stq  ra,0(sp)
Code;  fffffc00008f420c <__blk_cleanup_queue+2c/d0>
   4:   20 00 9e b5       stq  s3,32(sp)
Code;  fffffc00008f4210 <__blk_cleanup_queue+30/d0>
   8:   00 00 29 a6       ldq  a1,0(s0)
Code;  fffffc00008f4214 <__blk_cleanup_queue+34/d0>
   c:   a1 05 29 42       cmpeq        a1,s0,t0
Code;  fffffc00008f4218 <__blk_cleanup_queue+38/d0>
  10:   0f 00 20 f4       bne  t0,50 <_PC+0x50> fffffc00008f4258 <__blk_cleanup_queue+78/d0>
Code;  fffffc00008f421c <__blk_cleanup_queue+3c/d0>
  14:   d0 1a 9d a5       ldq  s3,6864(gp)
Code;  fffffc00008f4220 <__blk_cleanup_queue+40/d0>   <=====
  18:   00 00 31 a4       ldq  t0,0(a1)   <=====
Code;  fffffc00008f4224 <__blk_cleanup_queue+44/d0>
  1c:   08 00 51 a4       ldq  t1,8(a1)


3 warnings issued.  Results may not be reliable.
--8<-----

I should probably mention this is Red Hat 7.1 but with a self-built kernel (I
took the RH config file from their kernel-sources rpm and put it in my kernel
tree), so I believe gcc 2.96 was involved.

My (wild and uneducated) guess is that the DAC960 hasn't been ported to the
current VM. If I knew the kernel better, I would look into it myself (I might
anyway:), but any help would be much appreciated.

As I'm not subscribed to lkml, please keep me in the CC list.

TIA
Bill
