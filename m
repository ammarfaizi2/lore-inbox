Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131745AbQLIQnv>; Sat, 9 Dec 2000 11:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131781AbQLIQnm>; Sat, 9 Dec 2000 11:43:42 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:49676
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S131745AbQLIQne>; Sat, 9 Dec 2000 11:43:34 -0500
Date: Sat, 9 Dec 2000 11:23:00 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Alpha crash: 2.4.0-test12-pre6 + LVM 0.9 + REISERFS 3.6.22
Message-ID: <20001209112300.A15246@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this happened w/o reiserfs compiled or not.  I didn't leave
it running over night (crash happened about 07:00)

Last thing in the log before this was st being loaded (I have a backup that
starts at 06:00)  I don't believe this has anything to do with the crash,
but the machine crashed before with the same kernel (this was captured with
serial console, those things come in handy).

Here's the decoded oops

ksymoops 2.3.4 on alpha 2.2.17-LVM-RAID.  Options used
     -v /240t12p6-LVM-REISERFS (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test12-pre6-LVM-REISERFS/ (specified)
     -m /boot/System.map-2.4.0-test12-pre6-LVM-REISERFS (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 0000000000000228
swapper(0): Oops 1
pc = [<fffffc00003c8fc0>]  ra = [<fffffc00003c8fbc>]  ps = 0007
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000030000  t0 = 0000000000030000  t1 = fffffffffff21080
t2 = 0000000000000006  t3 = fffffc000015f9c8  t4 = 0000000000000000
t5 = fffffffffffffc18  t6 = fffffc00004520c0  t7 = fffffc0000468000
s0 = 0000000000000000  s1 = fffffc000015f800  s2 = 0000000000000006
s3 = fffffc000015f8b8  s4 = 0000000000000006  s5 = fffffc00004c6d40
s6 = 0000000000000000
a0 = fffffc00007a6140  a1 = 0000000000007000  a2 = fffffc000046bee8
a3 = 0000000000000001  a4 = fffffc000046c640  a5 = fffffc000048b2c0
t8 = 0000000000000000  t9 = 000000008cf1d8ff  t10= 0000000000000000
t11= 000006f800000004  pv = fffffc00004249e0  at = fffffc0000468000
gp = fffffc00004a8110  sp = fffffc000046be18
Code: 443ff001 2fe00000 402075a1 e4200006 d340004b 47ff041f <b0090228>
c3e00004

>>PC;  fffffc00003c8fc0 <isp1020_intr_handler+360/480>   <=====
Code;  fffffc00003c8fa8 <isp1020_intr_handler+348/480>
0000000000000000 <_PC>:
Code;  fffffc00003c8fa8 <isp1020_intr_handler+348/480>
   0:   01 f0 3f 44       and  t0,0xff,t0
Code;  fffffc00003c8fac <isp1020_intr_handler+34c/480>
   4:   00 00 e0 2f       unop 
Code;  fffffc00003c8fb0 <isp1020_intr_handler+350/480>
   8:   a1 75 20 40       cmpeq        t0,0x3,t0
Code;  fffffc00003c8fb4 <isp1020_intr_handler+354/480>
   c:   06 00 20 e4       beq  t0,28 <_PC+0x28> fffffc00003c8fd0
<isp1020_intr_handler+370/480>
Code;  fffffc00003c8fb8 <isp1020_intr_handler+358/480>
  10:   4b 00 40 d3       bsr  ra,140 <_PC+0x140> fffffc00003c90e8
<isp1020_return_status+8/120>
Code;  fffffc00003c8fbc <isp1020_intr_handler+35c/480>
  14:   1f 04 ff 47       nop  
Code;  fffffc00003c8fc0 <isp1020_intr_handler+360/480>   <=====
  18:   28 02 09 b0       stl  v0,552(s0)   <=====
Code;  fffffc00003c8fc4 <isp1020_intr_handler+364/480>
  1c:   04 00 e0 c3       br   30 <_PC+0x30> fffffc00003c8fd8
<isp1020_intr_handler+378/480>

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
