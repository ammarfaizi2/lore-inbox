Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUJTQfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUJTQfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUJTQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:33:52 -0400
Received: from brown.brainfood.com ([146.82.138.61]:58275 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S268553AbUJTQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:31:39 -0400
Date: Wed, 20 Oct 2004 11:31:38 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
In-Reply-To: <20041019124605.GA28896@elte.hu>
Message-ID: <Pine.LNX.4.58.0410201130360.1219@gradall.private.brainfood.com>
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

>
> i have released the -U6 Real-Time Preemption patch:
>
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6

Got these high-latency values during the night on U6(haven't booted U8 yet).

IRQ 5/431/CPU#0): 612 us critical section violates 100 us threshold.
 => started at timestamp 4167601478: <call_console_drivers+0x76/0x140>
 =>   ended at timestamp 4167602090: <finish_task_switch+0x43/0xb0>
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c01324de>] check_preempt_timing+0x15e/0x270
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c02a5717>] __sched_text_start+0x2d7/0x5d0
 [<c0113104>] mcount+0x14/0x18
 [<c013bdfa>] do_irqd+0x5a/0x80
 [<c01309ea>] kthread+0xaa/0xb0
 [<c013bda0>] do_irqd+0x0/0x80
 [<c0130940>] kthread+0x0/0xb0
 [<c0104099>] kernel_thread_helper+0x5/0xc
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x3b/0x5d0 / (do_irqd+0x5a/0x80)
.. entry 2: print_traces+0x1d/0x80 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 4167602447

(IRQ 5/431/CPU#0): 34875 us critical section violates 100 us threshold.
 => started at timestamp 4167608224: <call_console_drivers+0x76/0x140>
 =>   ended at timestamp 4167643099: <finish_task_switch+0x43/0xb0>
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c01324de>] check_preempt_timing+0x15e/0x270
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c02a5717>] __sched_text_start+0x2d7/0x5d0
 [<c0113104>] mcount+0x14/0x18
 [<c013bdfa>] do_irqd+0x5a/0x80
 [<c01309ea>] kthread+0xaa/0xb0
 [<c013bda0>] do_irqd+0x0/0x80
 [<c0130940>] kthread+0x0/0xb0
 [<c0104099>] kernel_thread_helper+0x5/0xc
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x3b/0x5d0 / (do_irqd+0x5a/0x80)
.. entry 2: print_traces+0x1d/0x80 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 4167643459

(IRQ 1/18/CPU#0): 30560 us critical section violates 100 us threshold.
 => started at timestamp 4167647182: <call_console_drivers+0x76/0x140>
 =>   ended at timestamp 4167677742: <finish_task_switch+0x43/0xb0>
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c01324de>] check_preempt_timing+0x15e/0x270
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c01327f0>] sub_preempt_count+0x60/0x90
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c0117ca3>] finish_task_switch+0x43/0xb0
 [<c02a5717>] __sched_text_start+0x2d7/0x5d0
 [<c0113104>] mcount+0x14/0x18
 [<c013bdfa>] do_irqd+0x5a/0x80
 [<c01309ea>] kthread+0xaa/0xb0
 [<c013bda0>] do_irqd+0x0/0x80
 [<c0130940>] kthread+0x0/0xb0
 [<c0104099>] kernel_thread_helper+0x5/0xc
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x3b/0x5d0 / (do_irqd+0x5a/0x80)
.. entry 2: print_traces+0x1d/0x80 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 4167678099

(bash/10595/CPU#0): 33546 us critical section violates 100 us threshold.
 => started at timestamp 4167681248: <call_console_drivers+0x76/0x140>
 =>   ended at timestamp 4167714794: <finish_task_switch+0x43/0xb0>
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
 [<c01182bb>] lock_kernel+0x2b/0x40
 [<c016f122>] sys_ioctl+0x52/0x230
 [<c0106013>] syscall_call+0x7/0xb
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __sched_text_start+0x3b/0x5d0 / (down_write+0x12f/0x1e0)
.. entry 2: print_traces+0x1d/0x80 / (dump_stack+0x23/0x30)

 =>   dump-end timestamp 4167715168

