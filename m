Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSKJAhC>; Sat, 9 Nov 2002 19:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSKJAhC>; Sat, 9 Nov 2002 19:37:02 -0500
Received: from smtp.comcast.net ([24.153.64.2]:44090 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S262826AbSKJAhB>;
	Sat, 9 Nov 2002 19:37:01 -0500
Date: Sat, 09 Nov 2002 19:43:41 -0500
From: Tom Vier <tmv@comcast.net>
Subject: 2.4.20-rc1 oops
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021110004341.GB656@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here's one i got on my up2000. single cpu, 667mhz.

ksymoops 2.4.5 on alpha 2.4.20-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rc1/ (default)
     -m /System.map-2.4.20-rc1 (specified)

Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says fffffffc004704a8, /lib/modules/2.4.20-rc1/kernel/drivers/scsi/sr_mod.o says fffffffc0046c000.  Ignoring /lib/modules/2.4.20-rc1/kernel/drivers/scsi/sr_mod.o entry
8139too Fast Ethernet driver 0.9.26
Unable to handle kernel paging request at virtual address 9b9092890046fe3c
klogd(200): Oops 0
pc = [<fffffc0000a254f0>]  ra = [<fffffc000082577c>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc007e63fed0  t0 = 2f73726576697264  t1 = 0000000000000000
t2 = ffffffffffffffff  t3 = 00000000000000f0  t4 = 646f6d7300000000
t5 = 00000000000000f8  t6 = 0000000000000080  t7 = fffffc007e63c000
s0 = fffffffc0046c000  s1 = fffffffc0046ffd8  s2 = 00000001200ad5e0
s3 = 0000000000000011  s4 = 0000000000000012  s5 = 0000000000000000
s6 = 0000000120017348
a0 = fffffc007e63ff08  a1 = 9b9092890046fe34  a2 = 0000000000000000
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 0000020000194088
t8 = 0000000000000000  t9 = fffffc000082577c  t10= 0000000000000008
t11= 000000000000000a  pv = 0000000000000000  at = fffffc00008257b4
gp = fffffc0000b35da0  sp = fffffc007e63fe98
Trace:fffffc0000810cc0 
Code: 47ff041f  47ff041f  c3ffffc3  47ff041f  47ff041f  47ff041f <2c710008> 42211411 


>>RA;  fffffc000082577c <sys_get_kernel_syms+13c/1e0>

>>PC;  fffffc0000a254f0 <__stxncpy+50/230>   <=====

Trace; fffffc0000810cc0 <entSys+a8/c0>

Code;  fffffc0000a254d8 <__stxncpy+38/230>
0000000000000000 <_PC>:
Code;  fffffc0000a254d8 <__stxncpy+38/230>
   0:   1f 04 ff 47       nop  
Code;  fffffc0000a254dc <__stxncpy+3c/230>
   4:   1f 04 ff 47       nop  
Code;  fffffc0000a254e0 <__stxncpy+40/230>
   8:   c3 ff ff c3       br   ffffffffffffff18 <_PC+0xffffffffffffff18> fffffc0000a253f0 <stxncpy_aligned+0/b0>
Code;  fffffc0000a254e4 <__stxncpy+44/230>
   c:   1f 04 ff 47       nop  
Code;  fffffc0000a254e8 <__stxncpy+48/230>
  10:   1f 04 ff 47       nop  
Code;  fffffc0000a254ec <__stxncpy+4c/230>
  14:   1f 04 ff 47       nop  
Code;  fffffc0000a254f0 <__stxncpy+50/230>   <=====
  18:   08 00 71 2c       ldq_u        t2,8(a1)   <=====
Code;  fffffc0000a254f4 <__stxncpy+54/230>
  1c:   11 14 21 42       addq a1,0x8,a1


1 warning issued.  Results may not be reliable.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
