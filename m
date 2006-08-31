Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWHaQ0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWHaQ0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWHaQ0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:26:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:50636 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932357AbWHaQ0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:26:37 -0400
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
From: Badari Pulavarty <pbadari@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, petkov@math.uni-muenster.de,
       akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200608311716.08786.ak@suse.de>
References: <20060820013121.GA18401@fieldses.org>
	 <200608310941.40076.ak@suse.de>
	 <1157036578.22667.6.camel@dyn9047017100.beaverton.ibm.com>
	 <200608311716.08786.ak@suse.de>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 09:29:50 -0700
Message-Id: <1157041790.22667.9.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 17:16 +0200, Andi Kleen wrote:

> 
> Don't know why sorry, but it seems to be indeed before the unwinder. 
> Maybe some state got messed up completely.

One more case.. May be this will help ?

- Badari

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/jbd/commit.c:177
invalid opcode: 0000 [1] SMP
CPU 1
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc
scsi_mod ipv6 thermal processor fan button battery ac dm_mod floppy
parport_pc lp parport
Pid: 4120, comm: kjournald Not tainted 2.6.18-rc4 #17
RIP: 0010:[<ffffffff8030e624>]  [<ffffffff8030e624>] my_ll_rw_block
+0xc4/0x120
RSP: 0000:ffff8101bf6dbd38  EFLAGS: 00010246
RAX: 0000000000020005 RBX: ffff8101d998b5b0 RCX: ffffffff805d73a8
RDX: ffffffff805d73a8 RSI: 0000000000000082 RDI: ffffffff805d73a0
RBP: ffff8101bf6dbd68 R08: ffffffff80754220 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000015000 R12: ffff8101c02b85b8
R13: 0000000000000037 R14: 0000000000000080 R15: 0000000000000080
FS:  00002b76fec046d0(0000) GS:ffff8101800a5140(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b76fe970751 CR3: 00000001dcdd9000 CR4: 00000000000006e0
Process kjournald (pid: 4120, threadinfo ffff8101bf6da000, task
ffff81018028b810)
Stack:  ffff8101dfe9a900 ffffffff80285340 ffff810171913910
ffff8101752334f0
 ffff8101de7da180 ffff8101df0f3400 ffff8101bf6dbe58 ffffffff8030eb3e
 ffff8101df0f3424 ffff8101df0f354c ffff8101de7da1f0 ffff8101c02b8400
Call Trace:
 [<ffffffff8030eb3e>] journal_commit_transaction+0x49e/0x11a0
 [<ffffffff80312f6e>] kjournald+0xde/0x290
 [<ffffffff8024562c>] kthread+0xdc/0x110
 [<ffffffff8020abe2>] child_rip+0x8/0x12
DWARF2 unwinder stuck at child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80245550>] kthread+0x0/0x110
 [<ffffffff8020abda>] child_rip+0x0/0x12


Code: 0f 0b 68 73 03 51 80 c2 b1 00 66 90 48 c7 43 38 40 53 28 80
RIP  [<ffffffff8030e624>] my_ll_rw_block+0xc4/0x120
 RSP <ffff8101bf6dbd38>
 <1>Unable to handle kernel paging request at 00000000e44bb818 RIP:
 [<ffffffff802277b8>] task_rq_lock+0x38/0x90
PGD 179aa1067 PUD 0
Oops: 0000 [2] SMP
CPU 3
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc
scsi_mod ipv6 thermal processor fan button battery ac dm_mod floppy
parport_pc lp parport
Pid: 0, comm: swapper Not tainted 2.6.18-rc4 #17
RIP: 0010:[<ffffffff802277b8>]  [<ffffffff802277b8>] task_rq_lock
+0x38/0x90
RSP: 0018:ffff8101a00f3e10  EFLAGS: 00010082
RAX: 000000002c7b6b7b RBX: ffffffff80754220 RCX: ffff8101df0f3590
RDX: 0000000000000000 RSI: ffff8101a00f3e68 RDI: ffff81018028b810
RBP: ffff8101a00f3e30 R08: 0000000000000000 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff80754220
R13: ffff81018028b810 R14: ffff8101a00f3e68 R15: 000000000000000a
FS:  00002b2cdc228400(0000) GS:ffff8101c00f1ec0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000e44bb818 CR3: 00000001dd1e4000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff8101800fa000, task
ffff81017a841100)
Stack:




