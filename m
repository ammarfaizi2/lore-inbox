Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVAYEgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVAYEgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVAYEgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:36:22 -0500
Received: from fsmlabs.com ([168.103.115.128]:35297 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261808AbVAYEgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:36:18 -0500
Date: Mon, 24 Jan 2005 21:36:37 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc2-mm1 Random related problems
Message-ID: <Pine.LNX.4.61.0501242134390.3010@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble booting here, were those random-* patches tested?

Initializing random number generator:  [  OK  ]
Unable to handle kernel paging request at virtual address f5e50000
 printing eip:
c037a0a5
*pde = 0086e067
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c037a0a5>]    Not tainted VLI
EFLAGS: 00010006   (2.6.11-rc2-mm1)
EIP is at __add_entropy_words+0xc5/0x1c0
eax: 0000002d   ebx: 0000000f   ecx: 0000007b   edx: f5e50000
esi: c0810980   edi: 0000000f   ebp: f5e4fea4   esp: f5e4fe5c
ds: 007b   es: 007b   ss: 0068
Process dd (pid: 2255, threadinfo=f5e4e000 task=ebdd7ac0)
Stack: 00000010 78000000 c07043e0 00000286 0000007b 0000001f 00000001 00000007
       0000000e 00000014 0000001a 00000000 0000002d f5e50000 c07043c0 00000080
       c0704340 c07043c0 f5e4ff40 c037a4e0 00000000 00000010 2cda69d0 f7b9f75e
Call Trace:
 [<c010403a>] show_stack+0x7a/0x90
 [<c01041c6>] show_registers+0x156/0x1c0
 [<c01043e0>] die+0x100/0x190
 [<c0116d59>] do_page_fault+0x349/0x63f
 [<c0103cc7>] error_code+0x2b/0x30
 [<c037a4e0>] xfer_secondary_pool+0xb0/0xe0
 [<c037a7ce>] extract_entropy_user+0x1e/0xd0
 [<c0163578>] vfs_read+0xe8/0x1a0
 [<c01638e1>] sys_read+0x41/0x70
 [<c010315d>] sysenter_past_esp+0x52/0x75
Code: ff 0f 84 cf 00 00 00 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 
b6 4d c8 89 f8 d3 c0 8945 bc 8b 45 e8 85 c0 7e 0e 8b 55 ec <8b> 0a 83 c2 
04 89 55 ec 89 4d c8 8b 4d cc 4b 8d 47 0e 8b 55 e0
 <3>Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c0104067>] dump_stack+0x17/0x20
 [<c011cf2c>] __might_sleep+0xac/0xc0
 [<c0120cd3>] profile_task_exit+0x23/0x60
 [<c0122fbc>] do_exit+0x1c/0x450
 [<c0104468>] die+0x188/0x190
 [<c0116d59>] do_page_fault+0x349/0x63f
 [<c0103cc7>] error_code+0x2b/0x30
 [<c037a4e0>] xfer_secondary_pool+0xb0/0xe0
 [<c037a7ce>] extract_entropy_user+0x1e/0xd0
 [<c0163578>] vfs_read+0xe8/0x1a0
 [<c01638e1>] sys_read+0x41/0x70
 [<c010315d>] sysenter_past_esp+0x52/0x75
note: dd[2255] exited with preempt_count 1
scheduling while atomic: dd/0x10000001/2255
 [<c0104067>] dump_stack+0x17/0x20
 [<c05e8fd2>] schedule+0xc82/0xc90
 [<c05e983a>] cond_resched+0x2a/0x50
 [<c0153709>] unmap_vmas+0x189/0x260
 [<c015810b>] exit_mmap+0x8b/0x160
 [<c011da91>] mmput+0x41/0xf0
 [<c0123047>] do_exit+0xa7/0x450
 [<c0104468>] die+0x188/0x190
 [<c0116d59>] do_page_fault+0x349/0x63f
 [<c0103cc7>] error_code+0x2b/0x30
 [<c037a4e0>] xfer_secondary_pool+0xb0/0xe0
 [<c037a7ce>] extract_entropy_user+0x1e/0xd0
 [<c0163578>] vfs_read+0xe8/0x1a0
 [<c01638e1>] sys_read+0x41/0x70
 [<c010315d>] sysenter_past_esp+0x52/0x75
/etc/rc3.d/S20random: line 57:  2255 Segmentation fault      dd 
if=/dev/urandom of=$random_seed count=1 bs=512 2>/dev/null
