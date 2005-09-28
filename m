Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVI1XPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVI1XPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVI1XPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:15:15 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:54458 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1751224AbVI1XPO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:15:14 -0400
Subject: 2.6.14-rc2: x86_64 SMP kernel crashes early during boot
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Sep 2005 16:14:03 -0700
Message-Id: <1127949243.26892.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on a dual Opteron system, running Fedora Core 3.  2.6.13 and
earlier are all fine.  I've included the last line of serial console
output, though it's not clear to me that it is related.

	<b

powernow-k8: Power state transitions not supported
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:1849
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 8, comm: events/0 Not tainted 2.6.14-rc2 #1
RIP: 0010:[<ffffffff8016e84c>] <ffffffff8016e84c>{free_block+316}
RSP: 0018:ffff81007fe79d58  EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff81007ff5ca80
RDX: ffff81007ff5ca80 RSI: 0000000000000320 RDI: ffff81007ff5ca80
RBP: ffff81007fe79da8 R08: ffff81007ff5d960 R09: 0000000000000000
R10: 000000000000001b R11: 0000000000000000 R12: ffff81007ff5e000
R13: ffff81007ff4bee0 R14: ffff81007ff5e048 R15: ffff81007ff5ca80
FS:  0000000000000000(0000) GS:ffffffff80550800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000491120 CR3: 0000000000101000 CR4: 00000000000006e0
Process events/0 (pid: 8, threadinfo ffff81007fe78000, task ffff8100024d8860)
Stack: 0000000000000000 0000000000000000 0000000200000000 ffff81007ff5dd90
       ffff81007ff5ca80 ffff81007ff5dd90 ffff81007ff5dd68 0000000000000002
       0000000000000000 ffff81007ff5ca80
Call Trace:<ffffffff8016eb2c>{drain_array_locked+188} <ffffffff80171119>{cache_reap+233}
       <ffffffff80149581>{worker_thread+545} <ffffffff80171030>{cache_reap+0}
       <ffffffff80131960>{default_wake_function+0} <ffffffff801319b0>{__wake_up_common+64}
       <ffffffff80131960>{default_wake_function+0} <ffffffff80149360>{worker_thread+0}
       <ffffffff8014dced>{kthread+221} <ffffffff8010ed46>{child_rip+8}
       <ffffffff8014dc10>{kthread+0} <ffffffff8010ed3e>{child_rip+0}


