Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbSJLXCd>; Sat, 12 Oct 2002 19:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJLXCd>; Sat, 12 Oct 2002 19:02:33 -0400
Received: from smtp.comcast.net ([24.153.64.2]:12920 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261366AbSJLXCc>;
	Sat, 12 Oct 2002 19:02:32 -0400
Date: Sat, 12 Oct 2002 19:08:16 -0400
From: Tom Vier <tmv@comcast.net>
Subject: 2.4.20-pre10 sound syms Oops
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021012230816.GA9237@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

got this on my alpha. i tried posting before, but it didn't seem to make it.
when sound is loaded, it tries to access virtual 0x4a8.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA

ksymoops 2.4.5 on alpha 2.4.20-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre10/ (default)
     -m /System.map-2.4.20-pre10 (specified)

Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says fffffffc003ae728, /lib/modules/2.4.20-pre10/kernel/drivers/scsi/sr_mod.o says fffffffc003aa000.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/scsi/sr_mod.o entry
Warning (compare_maps): mismatch on symbol sb_be_quiet  , sb_lib says fffffffc00389808, /lib/modules/2.4.20-pre10/kernel/drivers/sound/sb_lib.o says fffffffc0037e010.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/sound/sb_lib.o entry
Warning (compare_maps): mismatch on symbol smw_free  , sb_lib says fffffffc00389810, /lib/modules/2.4.20-pre10/kernel/drivers/sound/sb_lib.o says fffffffc0037e018.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/sound/sb_lib.o entry
Warning (compare_maps): mismatch on symbol num_audiodevs  , sound says fffffffc0037611c, /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o says fffffffc00362004.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_midis  , sound says fffffffc00376128, /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o says fffffffc00362010.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_mixers  , sound says fffffffc00376120, /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o says fffffffc00362008.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_sound_timers  , sound says fffffffc00376118, /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o says fffffffc00362000.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_synths  , sound says fffffffc00376124, /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o says fffffffc0036200c.  Ignoring /lib/modules/2.4.20-pre10/kernel/drivers/sound/sound.o entry
pci: pyxis 8K boundary dma bug - sg dma disabled
Unable to handle kernel paging request at virtual address 00000000000004a8
klogd(202): Oops 0
pc = [<fffffc0000827374>]  ra = [<fffffc000082735c>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc001e973ed0  t0 = 00000001200a5078  t1 = 0000000000000000
t2 = 65766972642f6c65  t3 = 0000000000000080  t4 = 6400000000000000
t5 = 0000000000000088  t6 = 0000000000000007  t7 = 0000000000000080
s0 = fffffffc003aa000  s1 = fffffffc003ae1d8  s2 = 00000001200a5030
s3 = 0000000000000009  s4 = 000000000000000a  s5 = 0000000000000000
s6 = 0000000120017348
a0 = fffffc001e973f08  a1 = fffffffc003ae021  a2 = 0000000000000000
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 0000020000194088
t8 = 00000001200a5078  t9 = fffffc000082735c  t10= 0000000000000008
t11= 000000000000000a  pv = 0000000000000008  at = fffffc0000827398
gp = fffffc0000b09d60  sp = fffffc001e973e98
Trace:fffffc0000810ce0 
Code: 27ba002e  23bd2a04  3bfe0073  41691416  2ffe0000  45691401 <a4480428> 44360401 


>>RA;  fffffc000082735c <sys_get_kernel_syms+15c/200>

>>PC;  fffffc0000827374 <sys_get_kernel_syms+174/200>   <=====

Trace; fffffc0000810ce0 <entSys+a8/c0>

Code;  fffffc000082735c <sys_get_kernel_syms+15c/200>
0000000000000000 <_PC>:
Code;  fffffc000082735c <sys_get_kernel_syms+15c/200>
   0:   2e 00 ba 27       ldah gp,46(ra)
Code;  fffffc0000827360 <sys_get_kernel_syms+160/200>
   4:   04 2a bd 23       lda  gp,10756(gp)
Code;  fffffc0000827364 <sys_get_kernel_syms+164/200>
   8:   73 00 fe 3b       stb  zero,115(sp)
Code;  fffffc0000827368 <sys_get_kernel_syms+168/200>
   c:   16 14 69 41       addq s2,0x48,t8
Code;  fffffc000082736c <sys_get_kernel_syms+16c/200>
  10:   00 00 fe 2f       unop 
Code;  fffffc0000827370 <sys_get_kernel_syms+170/200>
  14:   01 14 69 45       or   s2,0x48,t0
Code;  fffffc0000827374 <sys_get_kernel_syms+174/200>   <=====
  18:   28 04 48 a4       ldq  t1,1064(t7)   <=====
Code;  fffffc0000827378 <sys_get_kernel_syms+178/200>
  1c:   01 04 36 44       or   t0,t8,t0


8 warnings issued.  Results may not be reliable.
