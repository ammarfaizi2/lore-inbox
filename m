Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263379AbTDCNZ7>; Thu, 3 Apr 2003 08:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263382AbTDCNZ7>; Thu, 3 Apr 2003 08:25:59 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:12696 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263379AbTDCNZ6>; Thu, 3 Apr 2003 08:25:58 -0500
Date: Thu, 3 Apr 2003 14:37:18 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.66-bk vm oops.
Message-ID: <20030403133712.GA19693@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with BK from ~24hrs ago,..

kernel BUG at mm/slab.c:1582!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014ebab>]    Not tainted
EFLAGS: 00010016
EIP is at kmem_cache_free+0x24b/0x2c0
eax: 011999cc   ebx: 00010c00   ecx: 0000003c   edx: c7dedc74
esi: 81dfc120   edi: c3dfcd14   ebp: c198fd30   esp: c198fd08
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 6, threadinfo=c198e000 task=c198d980)
Stack: c7dedc74 c49138a0 00000000 c3dfc000 c0171d5c c19a3704 00000292 c198e000 
       c10df6d8 00000001 c198fd44 c0171d5c c7dedc74 c3dfcd18 c3dfcd18 c198fd78 
       c0171b1b c3dfcd18 c198fd68 c1ac14c8 c1066670 c198fe68 c198fd78 00000000 
Call Trace:
 [<c0171d5c>] free_buffer_head+0x2c/0x70
 [<c0171d5c>] free_buffer_head+0x2c/0x70
 [<c0171b1b>] try_to_free_buffers+0x13b/0x210
 [<c0152224>] shrink_list+0x4e4/0x5f0
 [<c010d425>] do_IRQ+0x235/0x350
 [<c0152529>] shrink_cache+0x1f9/0x600
 [<c015348b>] shrink_zone+0x9b/0xa0
 [<c0121590>] autoremove_wake_function+0x0/0x50
 [<c0153746>] balance_pgdat+0x116/0x180
 [<c015389d>] kswapd+0xed/0xf0
 [<c0121590>] autoremove_wake_function+0x0/0x50
 [<c010a306>] ret_from_fork+0x6/0x20
 [<c0121590>] autoremove_wake_function+0x0/0x50
 [<c01537b0>] kswapd+0x0/0xf0
 [<c01075fd>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 2e 06 e3 53 53 c0 e9 d7 fe ff ff 8b 55 08 8b 5a 34 e9

		Dave

