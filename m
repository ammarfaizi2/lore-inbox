Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVDED3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVDED3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 23:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVDED3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 23:29:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14503 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261268AbVDED3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 23:29:39 -0400
Date: Mon, 4 Apr 2005 23:29:39 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: linux-kernel@vger.kernel.org
Subject: Crash during boot for 2.6.12-rc2.
Message-ID: <Xine.LNX.4.44.0504042326280.9133-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this on a dual P4 Xeon with HT.  If anyone wants more information, 
let me know.


Creating /dev
Starting udev
input: AT Translated Set 2 keyboard on isa0060/serio0
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
------------[ cut here ]------------
kernel BUG at kernel/sched.c:2597!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c0115324>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc2) 
EIP is at sub_preempt_count+0x35/0x3f
eax: 00000100   ebx: c03a0394   ecx: c03a0370   edx: 00000001
esi: 00000000   edi: c01152db   ebp: f7fd464c   esp: f7fd464c
ds: 007b   es: 007b   ss: 0068
Process udev (pid: 57, threadinfo=f7fd4000 task=f7fd5a40)
Stack: f7fd4654 c034b416 f7fd466c c01342ec 00000217 f7fd4754 00000000 f7fd46b0 
       f7fd4678 c0112192 f7fd4754 f7fd4698 c0103eaa c0359df2 00000004 00000006 
       f7fd4754 00000000 c01040e0 f7fd474c c0104177 00000000 f7fd4754 00000000 
Call Trace:
 [<c01039d3>] show_stack+0x94/0xca
 [<c0103bad>] show_registers+0x18b/0x225
 [<c0103dcd>] die+0xfb/0x176
 [<c0104177>] do_invalid_op+0x97/0xa1
 [<c010360f>] error_code+0x4f/0x54
 [<c034b416>] _spin_unlock_irqrestore+0x24/0x4e
 [<c01342ec>] search_module_extables+0x78/0x82
 [<c0112192>] fixup_exception+0xe/0x2c
 [<c0103eaa>] do_trap+0x62/0xa4
 [<c0104177>] do_invalid_op+0x97/0xa1
 [<c010360f>] error_code+0x4f/0x54
 [<c034b099>] _spin_lock_irqsave+0x10/0x6f
 [<c0134289>] search_module_extables+0x15/0x82
 [<c0112192>] fixup_exception+0xe/0x2c
 [<c0103eaa>] do_trap+0x62/0xa4
 [<c0104177>] do_invalid_op+0x97/0xa1
 [<c010360f>] error_code+0x4f/0x54
 [<c034b099>] _spin_lock_irqsave+0x10/0x6f
 [<c0134289>] search_module_extables+0x15/0x82
 [<c0112192>] fixup_exception+0xe/0x2c
 [<c0103eaa>] do_trap+0x62/0xa4
 [<c0104177>] do_invalid_op+0x97/0xa1
 [<c010360f>] error_code+0x4f/0x54
 [<c034b099>] _spin_lock_irqsave+0x10/0x6f
 [<c0134289>] search_module_extables+0x15/0x82
 [<c0112192>] fixup_exception+0xe/0x2c
 [<c0103eaa>] do_trap+0x62/0xa4
 [<c0104177>] do_invalid_op+0x97/0xa1
 [<c010360f>] error_code+0x4f/0x54
 [<c034b099>] _spin_lock_irqsave+0x10/0x6f
 [<c0134289>] search_module_extables+0x15/0x82
 [<c0112192>] fixup_exception+0xe/0x2c
 [<c0103eaa>] do_trap+0x62/0xa4
 [<c0104177>] do_invalid_op+0x97/0xa1
 [<c010360f>] error_code+0x4f/0x54
 [<c034b099>] _spin_lock_irqsave+0x10/0x6f
 [<c0134289>] search_module_extables+0x15/0x82
 [<c0112192>] fixup_exception+0xe/0x2c
 [<c0103eaa>] do_trap+0x62/0xa4
 [<c0104177>] do_invalid_op+0x97/0xa1
 [<c010360f>] error_code+0x4f/0x54
 [<c034b031>] _spin_lock+0x10/0x68
 [<c016bae5>] d_alloc+0x121/0x1a4
 [<c01621d9>] real_lookup+0x9a/0xd4
 [<c016240d>] do_lookup+0x6a/0x75
 [<c0162573>] __link_path_walk+0x15b/0xdaf
 [<c0163213>] link_path_walk+0x4c/0xf2
 [<c0163553>] path_lookup+0xa3/0x19c
 [<c01637a8>] __user_walk+0x28/0x3b
 [<c015e166>] vfs_lstat+0x17/0x3d
 [<c015e6d1>] sys_lstat64+0x14/0x28
 [<c0102af9>] syscall_call+0x7/0xb
Code: 21 e0 8b 40 14 39 d0 7c 18 81 fa fe 00 00 00 77 04 84 c0 74 16 b8 00 f0 ff ff 21 e0 29 50 14 5d c3 0f 0b 21 0a 3c b8 35 c0 eb de <0f> 0b 25 0a 3c b8 35 c0 eb e0 55 89 e5 8b 40 04 5d e9 eb e2 ff 
 <0>Kernel panic - not syncing: Fatal exception in interrupt

