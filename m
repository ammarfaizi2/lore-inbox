Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTJ2OsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTJ2OsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:48:06 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:10114 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261463AbTJ2OsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:48:02 -0500
Date: Wed, 29 Oct 2003 14:47:32 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: VM related oops [2.6test7]
Message-ID: <20031029144732.GF7011@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhat old kernel, but I don't think I've seen this on the list.

		Dave


kernel BUG at mm/rmap.c:305!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0163280>]    Not tainted
EFLAGS: 00010246
EIP is at try_to_unmap_one+0x2b0/0x2c0
eax: c11b10c0   ebx: 000fe000   ecx: cad383f8   edx: c1000000
esi: 00000000   edi: c10fed08   ebp: cfa73d58   esp: cfa73d40
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=cfa72000 task=cfaa1980)
Stack: c10fed08 00040840 cad383f8 00000000 c10fed08 c10fed08 cfa73d7c c01633f2
       c016939a ffffffff 00000000 00000000 00000000 c10fed08 c10fed08 cfa73e20
       c0156d0b c10fed08 c04f6960 cfa72000 00000001 00000000 00000000 c11e2250
Call Trace:
 [<c01633f2>] try_to_unmap+0x162/0x180
 [<c016939a>] add_to_swap+0x8a/0xe0
 [<c0156d0b>] shrink_list+0x2eb/0xb50
 [<c015776f>] shrink_cache+0x1ff/0x5a0
 [<c0158938>] balance_pgdat+0x168/0x200
 [<c0158aa4>] kswapd+0xd4/0xf0
 [<c01238d0>] autoremove_wake_function+0x0/0x40
 [<c010a026>] ret_from_fork+0x6/0x20
 [<c01238d0>] autoremove_wake_function+0x0/0x40
 [<c01589d0>] kswapd+0x0/0xf0
 [<c0107545>] kernel_thread_helper+0x5/0x10
 
Code: 0f 0b 31 01 38 ce 47 c0 e9 81 fd ff ff 8d 76 00 55 89 e5 57
 <6>note: kswapd0[8] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43in_atomic():1, irqs_disabled():0
Call Trace:
 [<c012306d>] __might_sleep+0x8d/0xc0
 [<c0127d30>] profile_exit_task+0x10/0x50
 [<c0129dc4>] do_exit+0x74/0x8b0
 [<c010bb60>] do_invalid_op+0x0/0xb0
 [<c010b8d6>] die+0x1e6/0x1f0
 [<c010bc03>] do_invalid_op+0xa3/0xb0
 [<c0163280>] try_to_unmap_one+0x2b0/0x2c0
 [<c0307327>] elv_merged_request+0x27/0x30
 [<c030b397>] __make_request+0x567/0x710
 [<c010b16d>] error_code+0x2d/0x40
 [<c0163280>] try_to_unmap_one+0x2b0/0x2c0
 [<c01633f2>] try_to_unmap+0x162/0x180
 [<c016939a>] add_to_swap+0x8a/0xe0
 [<c0156d0b>] shrink_list+0x2eb/0xb50
 [<c015776f>] shrink_cache+0x1ff/0x5a0
 [<c0158938>] balance_pgdat+0x168/0x200
 [<c0158aa4>] kswapd+0xd4/0xf0
 [<c01238d0>] autoremove_wake_function+0x0/0x40
 [<c010a026>] ret_from_fork+0x6/0x20
 [<c01238d0>] autoremove_wake_function+0x0/0x40
 [<c01589d0>] kswapd+0x0/0xf0
 [<c0107545>] kernel_thread_helper+0x5/0x10
 


