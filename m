Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280329AbRJaRZw>; Wed, 31 Oct 2001 12:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280336AbRJaRZm>; Wed, 31 Oct 2001 12:25:42 -0500
Received: from mail201.mail.bellsouth.net ([205.152.58.141]:4427 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280333AbRJaRYq>; Wed, 31 Oct 2001 12:24:46 -0500
Message-ID: <3BE03401.406B8585@mandrakesoft.com>
Date: Wed, 31 Oct 2001 12:25:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pre6 BUG oops
Content-Type: multipart/mixed;
 boundary="------------3412690DCE6D9989E5A35B83"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3412690DCE6D9989E5A35B83
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

2.4.14-pre6 on UP alpha, newly reformatted and reinstalled :)

Machine was nowhere near OOM, and no other adverse messages appeared in
dmesg.  An rpm build and an rpm install were running in parallel.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------3412690DCE6D9989E5A35B83
Content-Type: text/plain; charset=us-ascii;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.1 on alpha 2.4.14-pre6.  Options used
     -v /home/jgarzik/cvs/linux_2_4/vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.14-pre6/ (specified)
     -m /boot/System.map-2.4.14-pre6 (specified)

Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says fffffffc002c2584, /lib/modules/2.4.14-pre6/kernel/net/packet/af_packet.o says fffffffc002be004.  Ignoring /lib/modules/2.4.14-pre6/kernel/net/packet/af_packet.o entry
kernel BUG at page_alloc.c:82!
rpmd(20216): Kernel Bug 1
pc = [__free_pages_ok+288/1040]  ra = [__free_pages_ok+276/1040]  ps = 0000    Tainted: P 
pc = [<fffffc0000841b50>]  ra = [<fffffc0000841b44>]  ps = 0000    Tainted: P 
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 000000000000001f  t0 = 0000000000000001  t1 = fffffc0016a0fec8
t2 = 0000000000000056  t3 = 0000000000000001  t4 = fffffc0000a3fcf8
t5 = fffffc0017d5a2c0  t6 = 0000000000000065  t7 = fffffc0008624000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 000000000000000e  a5 = 0000000000000001
t8 = fffffc0000a407f0  t9 = 0000000000004000  t10= fffffc0000a407f8
t11= fffffc0000a40808  pv = fffffc000081e1a0  at = 0000000000000000
gp = fffffc0000a3a8b8  sp = fffffc0008627d58
Trace:fffffc0000836160 fffffc0000835e28 fffffc0000836160 fffffc0000836338 fffffc00008364b4 fffffc0000865768 fffffc0000862e3c fffffc0000859c30 fffffc0000859dc0 fffffc0000810b10 
Code: 225f0052  a77da6e0  6b5b4083  27ba0020  23bd8d74  00000081 <a04a0000> 44481001 

>>PC;  fffffc0000841b50 <__free_pages_ok+120/410>   <=====
Trace; fffffc0000836160 <truncate_complete_page+90/b0>
Trace; fffffc0000835e28 <remove_inode_page+48/60>
Trace; fffffc0000836160 <truncate_complete_page+90/b0>
Trace; fffffc0000836338 <truncate_list_pages+1b8/2d0>
Trace; fffffc00008364b4 <truncate_inode_pages+64/d0>
Trace; fffffc0000865768 <iput+108/270>
Trace; fffffc0000862e3c <d_delete+7c/c0>
Trace; fffffc0000859c30 <vfs_unlink+190/230>
Trace; fffffc0000859dc0 <sys_unlink+f0/1f0>
Trace; fffffc0000810b10 <entSys+a8/c0>
Code;  fffffc0000841b38 <__free_pages_ok+108/410>
0000000000000000 <_PC>:
Code;  fffffc0000841b38 <__free_pages_ok+108/410>
   0:   52 00 5f 22       lda  a2,82(zero)
Code;  fffffc0000841b3c <__free_pages_ok+10c/410>
   4:   e0 a6 7d a7       ldq  t12,-22816(gp)
Code;  fffffc0000841b40 <__free_pages_ok+110/410>
   8:   83 40 5b 6b       jsr  ra,(t12),218 <_PC+0x218> fffffc0000841d50 <__free_pages_ok+320/410>
Code;  fffffc0000841b44 <__free_pages_ok+114/410>
   c:   20 00 ba 27       ldah gp,32(ra)
Code;  fffffc0000841b48 <__free_pages_ok+118/410>
  10:   74 8d bd 23       lda  gp,-29324(gp)
Code;  fffffc0000841b4c <__free_pages_ok+11c/410>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc0000841b50 <__free_pages_ok+120/410>   <=====
  18:   00 00 4a a0       ldl  t1,0(s1)   <=====
Code;  fffffc0000841b54 <__free_pages_ok+124/410>
  1c:   01 10 48 44       and  t1,0x40,t0


1 warning issued.  Results may not be reliable.

--------------3412690DCE6D9989E5A35B83--


