Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVLJWwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVLJWwI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 17:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVLJWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 17:52:08 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:5079 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S1751276AbVLJWwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 17:52:07 -0500
Date: Sat, 10 Dec 2005 23:52:01 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20051210.143523.106612727.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512102350310.4739@lai.local.lan>
References: <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
 <20051207.133236.97581111.davem@davemloft.net> <Pine.LNX.4.64.0512102314530.4626@lai.local.lan>
 <20051210.143523.106612727.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2005, David S. Miller wrote:

> It doesn't trigger for me here with the Xorg server, on an
> Ultra60 with CreatorFB.  I do get the cursor in the corner
> and a non-functional screen but I can switch around to other
> VC's and kill the X server cleanly.  I definitely don't get
> those kernel log messages.
>
> Please retest with this debug tracing added:

This generates two extra lines in the dmesg output, I have included the 
bug message too, just in case.

IO[X:6761]: 
remap_pfn_range(s[71800000]e[71c10000],f[71800000],pfn[1fc0060],sz[2000],prot[80000000000006b0])
IO[X:6761]: 
remap_pfn_range(s[71800000]e[71c10000],f[71802000],pfn[1fc0060],sz[2000],prot[80000000000006b0])
kernel BUG at arch/sparc64/mm/generic.c:77!
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
X(6761): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009603 TPC: 0000000000434da0 TNPC: 0000000000434da4 Y: 
00000000    Not tainted
TPC: <io_remap_pfn_range+0x400/0x420>
g0: fffff8000703f261 g1: 0000000000669400 g2: 0000000000000001 g3: 
0000000000001f4c
g4: fffff80007e2aa60 g5: 0000000000000010 g6: fffff80007030000 g7: 
0000000000000000
o0: 000000000000002f o1: 000000000061f1a8 o2: 000000000000004d o3: 
0000000011812000
o4: 000001fc00610000 o5: fffff800041b8c00 sp: fffff8000703f241 ret_pc: 
0000000000434d98
RPC: <io_remap_pfn_range+0x3f8/0x420>
l0: 0000000071802000 l1: 000001fb8edfe000 l2: 0000000071804000 l3: 
000001fb8edfe000
l4: 000001fb8edfe000 l5: e000000000000f8a l6: a000000000000f8a l7: 
c000000000000f8a
i0: 0000000071804000 i1: 0000000071802000 i2: 0000000000000000 i3: 
0000000071802000
i4: 80000000000006b0 i5: fffff80005a7000c i6: fffff8000703f361 i7: 
000000000053b224
I7: <sbusfb_mmap_helper+0x104/0x160>
Caller[000000000053b224]: sbusfb_mmap_helper+0x104/0x160
Caller[00000000005335b4]: fb_mmap+0x134/0x160
Caller[0000000000478748]: do_mmap_pgoff+0x368/0x720
Caller[00000000004161d8]: sys_mmap+0xf8/0x160
Caller[0000000000406c94]: linux_sparc_syscall32+0x34/0x40
Caller[0000000000286378]: 0x286378
Instruction DUMP: 9210204d  7fff6e02  901221a8 <91d02005> 7ffff76f 
b13ee000  81cfe008  01000000  30680003

-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
