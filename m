Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLaQTA>; Sun, 31 Dec 2000 11:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQLaQSk>; Sun, 31 Dec 2000 11:18:40 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:26894
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129383AbQLaQSf>; Sun, 31 Dec 2000 11:18:35 -0500
Date: Sun, 31 Dec 2000 10:57:43 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Slightly old kernel on alpha crash
Message-ID: <20001231105743.A10997@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=HlL+5n6rz5pIUxbD
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii

This is 2.4.0-test12pre6.  Wondering if anyone's looked into this yet.  I
have the 0.9LVM patch and REISERFS patch.  I have attached the decoded oops

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=alpha_crash-ksymoops

ksymoops 2.3.4 on alpha 2.4.0-test12-pre6-LVM-REISERFS.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12-pre6-LVM-REISERFS/ (default)
     -m /boot/System.map-2.4.0-test12-pre6-LVM-REISERFS (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol tulip_debug  , tulip says fffffffc001f3b1c, /lib/modules/2.4.0-test12-pre6-LVM-REISERFS/kernel/drivers/net/tulip/tulip.o says fffffffc001f3df4.  Ignoring /lib/modules/2.4.0-test12-pre6-LVM-REISERFS/kernel/drivers/net/tulip/tulip.o entry
Unable to handle kernel paging request at virtual address 0000000000000228
swapper(0): Oops 1
pc = [<fffffc00003c8fe0>]  ra = [<fffffc00003c8fdc>]  ps = 0007
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000030000  t0 = 0000000000030000  t1 = fffffffffff210a0
t2 = 0000000000000006  t3 = fffffc000015f9c8  t4 = 0000000000000000
t5 = fffffffffffffc18  t6 = fffffc00004520c0  t7 = fffffc0000468000
s0 = 0000000000000000  s1 = fffffc000015f800  s2 = 0000000000000003
s3 = fffffc000015f8b8  s4 = 0000000000000003  s5 = fffffc00004c6d40
s6 = 0000000000000000
a0 = fffffc00007a6080  a1 = 0000000000007000  a2 = fffffc000046bee8
a3 = 0000000000000001  a4 = fffffc000046c640  a5 = fffffc000048b2c0
t8 = 0000000000000000  t9 = 0000000098d78111  t10= 0000000000000000
t11= 000006f800000004  pv = fffffc0000424a00  at = fffffc0000468000
gp = fffffc00004a8110  sp = fffffc000046be18
Code: 443ff001 2fe00000 402075a1 e4200006 d340004b 47ff041f <b0090228> c3e00004

>>PC;  fffffc00003c8fe0 <isp1020_intr_handler+360/480>   <=====
Code;  fffffc00003c8fc8 <isp1020_intr_handler+348/480>
0000000000000000 <_PC>:
Code;  fffffc00003c8fc8 <isp1020_intr_handler+348/480>
   0:   01 f0 3f 44       and  t0,0xff,t0
Code;  fffffc00003c8fcc <isp1020_intr_handler+34c/480>
   4:   00 00 e0 2f       unop 
Code;  fffffc00003c8fd0 <isp1020_intr_handler+350/480>
   8:   a1 75 20 40       cmpeq        t0,0x3,t0
Code;  fffffc00003c8fd4 <isp1020_intr_handler+354/480>
   c:   06 00 20 e4       beq  t0,28 <_PC+0x28> fffffc00003c8ff0 <isp1020_intr_handler+370/480>
Code;  fffffc00003c8fd8 <isp1020_intr_handler+358/480>
  10:   4b 00 40 d3       bsr  ra,140 <_PC+0x140> fffffc00003c9108 <isp1020_return_status+8/120>
Code;  fffffc00003c8fdc <isp1020_intr_handler+35c/480>
  14:   1f 04 ff 47       nop  
Code;  fffffc00003c8fe0 <isp1020_intr_handler+360/480>   <=====
  18:   28 02 09 b0       stl  v0,552(s0)   <=====
Code;  fffffc00003c8fe4 <isp1020_intr_handler+364/480>
  1c:   04 00 e0 c3       br   30 <_PC+0x30> fffffc00003c8ff8 <isp1020_intr_handler+378/480>


2 warnings issued.  Results may not be reliable.

--HlL+5n6rz5pIUxbD--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
