Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269724AbUJSTEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269724AbUJSTEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269618AbUJSTBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:01:31 -0400
Received: from brown.brainfood.com ([146.82.138.61]:8576 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S269645AbUJSSyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:54:04 -0400
Date: Tue, 19 Oct 2004 13:54:02 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
In-Reply-To: <20041019124605.GA28896@elte.hu>
Message-ID: <Pine.LNX.4.58.0410191353300.1219@gradall.private.brainfood.com>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
 <20041019124605.GA28896@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, Ingo Molnar wrote:

> i have released the -U6 Real-Time Preemption patch:

(xterm/1219/CPU#0): new 39188 us maximum-latency critical section.
 => started at timestamp 71898423: <call_console_drivers+0x76/0x140>
 =>   ended at timestamp 71937611: <finish_task_switch+0x43/0xb0>
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c01324de>] check_preempt_timing+0x15e/0x270
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c02a5717>] __sched_text_start+0x2d7/0x5d0
 [<c02a684f>] down_write+0x12f/0x1e0
 [<c0113104>] mcount+0x14/0x18
 [<c02a684f>] down_write+0x12f/0x1e0
 [<c014dd45>] remove_vm_struct+0x45/0xb0
 [<c014fde2>] exit_mmap+0xf2/0x120
 [<c0119b96>] mmput+0x46/0xf0
 [<c0166d8f>] exec_mmap+0xaf/0x140
 [<c0166ffd>] flush_old_exec+0xfd/0x7f0
 [<c015b917>] vfs_read+0xe7/0x140
 [<c0113104>] mcount+0x14/0x18
 [<c0185d7f>] load_elf_binary+0x30f/0xbd0
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c01db739>] up_read+0xf9/0x140
 [<c01323d8>] check_preempt_timing+0x58/0x270
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c0131c6d>] __mcount+0x1d/0x20
 [<c0185a70>] load_elf_binary+0x0/0xbd0
 [<c0167aba>] search_binary_handler+0x19a/0x2e0
 [<c0167dac>] do_execve+0x1ac/0x260
 [<c0104b07>] sys_execve+0x47/0xd0
 [<c0106013>] syscall_call+0x7/0xb
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x3b/0x5d0 / (down_write+0x12f/0x1e0)
.. entry 2: print_traces+0x1d/0x80 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 71938197
