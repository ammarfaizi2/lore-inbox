Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSHDLVO>; Sun, 4 Aug 2002 07:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318154AbSHDLVN>; Sun, 4 Aug 2002 07:21:13 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:824 "EHLO devil.stev.org")
	by vger.kernel.org with ESMTP id <S318153AbSHDLVN>;
	Sun, 4 Aug 2002 07:21:13 -0400
Message-ID: <003401c23ba9$35900d20$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Alpha opps on 2.4.19
Date: Sun, 4 Aug 2002 12:22:24 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup the following happens.

Error (regular_file): read_system_map stat /boot/System.map-2.4.3-12 failed
Unable to handle kernel paging request at virtual address 02bffc0000651608
init(1): Oops 0
pc = [<fffffc00003446a0>]  ra = [<fffffc000034490c>]  ps = 0000    Not
tainted
Using defaults from ksymoops -t elf64-alpha
v0 = fffffc000055e6d0  t0 = 0007ffffffffff85  t1 = fffffc00001f2000
t2 = 02bffc00006515d8  t3 = fffffc0000654020  t4 = 00000000000003ff
t5 = 0000000000040305  t6 = 000000011ffff718  t7 = fffffc000bfcc000
s0 = 00000200001b49c0  s1 = fffffc000051a0c0  s2 = fffffc00005c6a28
s3 = fffffc000051a0c0  s4 = fffffc0000516880  s5 = fffffc000055e6d0
s6 = 0000000000000001
a0 = fffffc000051a0c0  a1 = fffffc0000516880  a2 = fffffc000055e6d0
a3 = 0000000000000001  a4 = 00000200001b49c0  a5 = 000000000000001a
t8 = 0000000000000008  t9 = 0000020000019020  t10= fffffc00003135c8
t11= fffffc000bfcfcd8  pv = 0000000000000000  at = 000002000002c788
gp = fffffc000060a180  sp = fffffc000bfcfab8
Trace:fffffc000034490c fffffc0000344ca8 fffffc000032bd08 fffffc00003469e8
fffff
Code: a4820640  40230521  4821b681  40210563  40610563  40640643 <a4230030>
482
Error (Oops_code_values): invalid value 0x482 in Code line, must be 2, 4, 8
or 16 digits, value ignored

>>PC;  fffffc00003446a0 <do_anonymous_page+70/280>   <=====
Trace; fffffc000034490c <do_no_page+5c/320>
Trace; fffffc0000344ca8 <handle_mm_fault+d8/1d0>
Trace; fffffc000032bd08 <do_page_fault+238/4f0>
Trace; fffffc00003469e8 <sys_munmap+78/e0>
Trace; 00000000000fffff Before first symbol
Code;  fffffc0000344688 <do_anonymous_page+58/280>
0000000000000000 <_PC>:
Code;  fffffc0000344688 <do_anonymous_page+58/280>
   0:   40 06 82 a4       ldq  t3,1600(t1)
Code;  fffffc000034468c <do_anonymous_page+5c/280>
   4:   21 05 23 40       subq t0,t2,t0
Code;  fffffc0000344690 <do_anonymous_page+60/280>
   8:   81 b6 21 48       srl  t0,0xd,t0
Code;  fffffc0000344694 <do_anonymous_page+64/280>
   c:   63 05 21 40       s4subq       t0,t0,t2
Code;  fffffc0000344698 <do_anonymous_page+68/280>
  10:   63 05 61 40       s4subq       t2,t0,t2
Code;  fffffc000034469c <do_anonymous_page+6c/280>
  14:   43 06 64 40       s8addq       t2,t3,t2
Code;  fffffc00003446a0 <do_anonymous_page+70/280>
  18:   30 00 23 a4       ldq  t0,48(t2)

Kernel panic: Attempted to kill init!

2 errors issued.  Results may not be reliable.


--------------------------
Mobile: +44 07779080838
http://www.stev.org
 12:00pm  up 13:47,  3 users,  load average: 0.00, 0.02, 0.00



