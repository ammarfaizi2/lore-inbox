Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUJOCd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUJOCd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUJOCd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:33:59 -0400
Received: from brown.brainfood.com ([146.82.138.61]:33664 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S268126AbUJOCd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:33:56 -0400
Date: Thu, 14 Oct 2004 21:33:54 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
In-Reply-To: <20041014234202.GA26207@elte.hu>
Message-ID: <Pine.LNX.4.58.0410142133090.1224@gradall.private.brainfood.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Ingo Molnar wrote:

>
> i have released the -U2 PREEMPT_REALTIME patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2

scheduling while atomic: XFree86/0x04000002/1129
caller is cond_resched+0x53/0x70
 [<c027acd7>] schedule+0x517/0x550
 [<c012ce6a>] check_preempt_timing+0x1a/0x130
 [<c0107b98>] do_IRQ+0x58/0x80
 [<c027b243>] cond_resched+0x53/0x70
 [<c012c684>] _mutex_lock+0x14/0x40
 [<c012c6d5>] _mutex_lock_irqsave+0x5/0x10
 [<c01b28bf>] avc_has_perm_noaudit+0x10f/0x180
 [<c012ce6a>] check_preempt_timing+0x1a/0x130
 [<c01b296a>] avc_has_perm+0x3a/0x78
 [<c014de87>] shmem_truncate+0x1d7/0x400
 [<c01b8060>] ipc_has_perm+0x70/0x90
 [<c027b209>] cond_resched+0x19/0x70
 [<c01a9c72>] ipcperms+0x72/0xa0
 [<c01adaf7>] do_shmat+0xc7/0x300
 [<c010b8b6>] sys_ipc+0x1c6/0x280
 [<c01c8040>] copy_to_user+0x40/0x60
 [<c011d69c>] sys_gettimeofday+0x2c/0x70
 [<c01057fb>] syscall_call+0x7/0xb
scheduling while atomic: liquidwar/0x04000002/1553
caller is cond_resched+0x53/0x70
 [<c027acd7>] schedule+0x517/0x550
 [<c012ce6a>] check_preempt_timing+0x1a/0x130
 [<c027b243>] cond_resched+0x53/0x70
 [<c012c684>] _mutex_lock+0x14/0x40
 [<c012c6d5>] _mutex_lock_irqsave+0x5/0x10
 [<c01b27da>] avc_has_perm_noaudit+0x2a/0x180
 [<c01b2992>] avc_has_perm+0x62/0x78
 [<c01b296a>] avc_has_perm+0x3a/0x78
 [<c012c690>] _mutex_lock+0x20/0x40
 [<c01b8060>] ipc_has_perm+0x70/0x90
 [<c01b8060>] ipc_has_perm+0x70/0x90
 [<c0107b98>] do_IRQ+0x58/0x80
 [<c01adb13>] do_shmat+0xe3/0x300
 [<c010b8b6>] sys_ipc+0x1c6/0x280
 [<c0147a4f>] sys_munmap+0x3f/0x60
 [<c01057fb>] syscall_call+0x7/0xb

