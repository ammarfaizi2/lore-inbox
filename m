Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUJPC6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUJPC6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 22:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268581AbUJPC6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 22:58:17 -0400
Received: from brown.brainfood.com ([146.82.138.61]:7299 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S268565AbUJPC6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 22:58:12 -0400
Date: Fri, 15 Oct 2004 21:58:06 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
In-Reply-To: <20041015102633.GA20132@elte.hu>
Message-ID: <Pine.LNX.4.58.0410152157030.1219@gradall.private.brainfood.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
 <20041015102633.GA20132@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Ingo Molnar wrote:

>
> i have released the -U3 PREEMPT_REALTIME patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3

scheduling while atomic: postmaster/0x04000002/3175
caller is cond_resched+0x53/0x70
 [<c01069f7>] dump_stack+0x17/0x20
 [<c027b457>] schedule+0x517/0x550
 [<c027b9c3>] cond_resched+0x53/0x70
 [<c012cdc7>] _mutex_lock+0x17/0x40
 [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
 [<c01b21ae>] avc_has_perm_noaudit+0x2e/0x180
 [<c01b2335>] avc_has_perm+0x35/0x68
 [<c01b79ca>] ipc_has_perm+0x6a/0x80
 [<c01ab716>] semctl_main+0xa6/0x410
 [<c01abcad>] sys_semctl+0xad/0xb0
 [<c010bafd>] sys_ipc+0xad/0x250
 [<c0105bff>] syscall_call+0x7/0xb
scheduling while atomic: postmaster/0x04000002/5260
caller is cond_resched+0x53/0x70
 [<c01069f7>] dump_stack+0x17/0x20
 [<c027b457>] schedule+0x517/0x550
 [<c027b9c3>] cond_resched+0x53/0x70
 [<c012cdc7>] _mutex_lock+0x17/0x40
 [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
 [<c01b21ae>] avc_has_perm_noaudit+0x2e/0x180
 [<c01b2335>] avc_has_perm+0x35/0x68
 [<c01b79ca>] ipc_has_perm+0x6a/0x80
 [<c01a9832>] ipcperms+0x82/0xb0
 [<c01ab6fe>] semctl_main+0x8e/0x410
 [<c01abcad>] sys_semctl+0xad/0xb0
 [<c010bafd>] sys_ipc+0xad/0x250
 [<c0105bff>] syscall_call+0x7/0xb
scheduling while atomic: liquidwar/0x04000002/5505
caller is cond_resched+0x53/0x70
 [<c01069f7>] dump_stack+0x17/0x20
 [<c027b457>] schedule+0x517/0x550
 [<c027b9c3>] cond_resched+0x53/0x70
 [<c012cdc7>] _mutex_lock+0x17/0x40
 [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
 [<c01b21ae>] avc_has_perm_noaudit+0x2e/0x180
 [<c01b2335>] avc_has_perm+0x35/0x68
 [<c01b79ca>] ipc_has_perm+0x6a/0x80
 [<c01acfe6>] sys_shmctl+0x196/0x690
 [<c010bc9a>] sys_ipc+0x24a/0x250
 [<c0105bff>] syscall_call+0x7/0xb
scheduling while atomic: XFree86/0x04000002/1127
caller is cond_resched+0x53/0x70
 [<c01069f7>] dump_stack+0x17/0x20
 [<c027b457>] schedule+0x517/0x550
 [<c027b9c3>] cond_resched+0x53/0x70
 [<c012cdd3>] _mutex_lock+0x23/0x40
 [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
 [<c01b228e>] avc_has_perm_noaudit+0x10e/0x180
 [<c01b2335>] avc_has_perm+0x35/0x68
 [<c01b79ca>] ipc_has_perm+0x6a/0x80
 [<c01ad30d>] sys_shmctl+0x4bd/0x690
 [<c010bc9a>] sys_ipc+0x24a/0x250
 [<c0105bff>] syscall_call+0x7/0xb
scheduling while atomic: XFree86/0x04000002/1127
caller is cond_resched+0x53/0x70
 [<c01069f7>] dump_stack+0x17/0x20
 [<c027b457>] schedule+0x517/0x550
 [<c027b9c3>] cond_resched+0x53/0x70
 [<c012cdc7>] _mutex_lock+0x17/0x40
 [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
 [<c01b21ae>] avc_has_perm_noaudit+0x2e/0x180
 [<c01b2335>] avc_has_perm+0x35/0x68
 [<c01b79ca>] ipc_has_perm+0x6a/0x80
 [<c01a9832>] ipcperms+0x82/0xb0
 [<c01ad59f>] do_shmat+0xbf/0x2e0
 [<c010bbef>] sys_ipc+0x19f/0x250
 [<c0105bff>] syscall_call+0x7/0xb
scheduling while atomic: liquidwar/0x04000002/5505
caller is cond_resched+0x53/0x70
 [<c01069f7>] dump_stack+0x17/0x20
 [<c027b457>] schedule+0x517/0x550
 [<c027b9c3>] cond_resched+0x53/0x70
 [<c012cdc7>] _mutex_lock+0x17/0x40
 [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
 [<c01b21ae>] avc_has_perm_noaudit+0x2e/0x180
 [<c01b2335>] avc_has_perm+0x35/0x68
 [<c01b79ca>] ipc_has_perm+0x6a/0x80
 [<c01ad5ba>] do_shmat+0xda/0x2e0
 [<c010bbef>] sys_ipc+0x19f/0x250
 [<c0105bff>] syscall_call+0x7/0xb
scheduling while atomic: liquidwar/0x04000002/5505
caller is cond_resched+0x53/0x70
 [<c01069f7>] dump_stack+0x17/0x20
 [<c027b457>] schedule+0x517/0x550
 [<c027b9c3>] cond_resched+0x53/0x70
 [<c012cdc7>] _mutex_lock+0x17/0x40
 [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
 [<c01b21ae>] avc_has_perm_noaudit+0x2e/0x180
 [<c01b2335>] avc_has_perm+0x35/0x68
 [<c01b79ca>] ipc_has_perm+0x6a/0x80
 [<c01a9832>] ipcperms+0x82/0xb0
 [<c01ad59f>] do_shmat+0xbf/0x2e0
 [<c010bbef>] sys_ipc+0x19f/0x250
 [<c0105bff>] syscall_call+0x7/0xb

