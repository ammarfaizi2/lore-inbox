Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVLFCEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVLFCEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVLFCEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:04:15 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:42373 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S964833AbVLFCEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:04:13 -0500
Date: Tue, 6 Dec 2005 03:04:11 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: linux-kernel maillist <linux-kernel@vger.kernel.org>
Subject: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-ID: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been struggling with getting Xorg (6.8.2 and 7.0.0rc1) to work on 
a Sun Ultra10 (Sparc IIi), the 6.8.2 works under kernel 2.4.

Tested kernels:
  2.6.13
  2.6.14.2 (patch to a patch or what?)
  2.6.15-rc1
  2.6.15-rc2

The dmesg entry comes from 2.6.15-rc2, but is kind of the same, expect not 
all versions has the ugly and annoying face.

--- dmesg ---
program X is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED memory, 
which is
deprecated. Please report this to linux-kernel@vger.kernel.org
kernel BUG at arch/sparc64/mm/generic.c:68!
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
X(6885): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009603 TPC: 0000000000434d58 TNPC: 0000000000434d5c Y: 
0000000
0    Not tainted
TPC: <io_remap_pfn_range+0x3b8/0x3e0>
g0: fffff800068ba200 g1: 0000000000668c00 g2: 0000000000000001 g3: 
0000000000001
f22
g4: fffff80004324360 g5: 0000000000000010 g6: fffff80000a90000 g7: 
0000000000000
000
o0: 000000000000002f o1: 000000000061e7c8 o2: 0000000000000044 o3: 
0000000012c12
000
o4: 800001fc00600f8a o5: 000001fc00610000 sp: fffff80000a9f271 ret_pc: 
000000000
0434d50
RPC: <io_remap_pfn_range+0x3b0/0x3e0>
l0: 0000000072c04000 l1: 000001fb8d9fe000 l2: 0000000072c04000 l3: 
000001fb8d9fe
000
l4: 000001fb8d9fe000 l5: e000000000000f8a l6: a000000000000f8a l7: 
c000000000000
f8a
i0: 0000000072c02000 i1: 0000000072c02000 i2: fffff80005630000 i3: 
0000000072c02
000
i4: 80000000000006b0 i5: fffff800019a000c i6: fffff80000a9f361 i7: 
000000000053b
7e4
I7: <sbusfb_mmap_helper+0x104/0x160>
Caller[000000000053b7e4]: sbusfb_mmap_helper+0x104/0x160
Caller[0000000000533b74]: fb_mmap+0x134/0x160
Caller[00000000004784a8]: do_mmap_pgoff+0x368/0x780
Caller[00000000004161d8]: sys_mmap+0xf8/0x160
Caller[0000000000406c94]: linux_sparc_syscall32+0x34/0x40
Caller[0000000000286378]: 0x286378
Instruction DUMP: 92102044  7fff6e14  901223c8 <91d02005> 7ffff781 
b13e2000  81
cfe008  01000000  30680005
---- eof ----


-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
