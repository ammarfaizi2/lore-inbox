Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbUKHRoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUKHRoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUKHRnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:43:31 -0500
Received: from mail8.spymac.net ([195.225.149.8]:44419 "EHLO mail8")
	by vger.kernel.org with ESMTP id S261708AbUKHRlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:41:36 -0500
Message-ID: <418FAFC5.7070000@spymac.com>
Date: Mon, 08 Nov 2004 18:41:25 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.21
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
In-Reply-To: <20041108165718.GA7741@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -V0.7.21 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
>this release includes fixes and debugging-improvements.
>
>Changes since -V0.7.20:
>
> - reverted the modlist_lock change - it caused more problems than it 
>   solved.
>
> - implemented irqs-off critical section timing/tracing, inspired by the 
>   positive results Thomas Gleixner got with a different kind of cli/sti
>   tracer. To activate it, enable CONFIG_CRITICAL_TIMING and 
>   CONFIG_CRITICAL_IRQSOFF_TIMING and cli/sti latencies will be reported
>   'integrated' into the preempt on/off latencies.
>
> - sped up tracing in a number of ways. Performance of the tracer slowly
>   eroded in the past week or two, it needed alignment and size fixes ,
>   inlining/branch-prediction updates and i got rid of unnecessary code.
>   The max latency is now traced in cycles - this got rid of an
>   expensive 64-bit division in the fastpath. (the /proc/sys tunables
>   are still in usecs so userspace should not notice anything.) It's
>   still not cheap but roughly 5 times faster than -V0.7.20's tracer, on
>   a fast desktop box.
>
> - renamed CONFIG_PREEMPT_REALTIME to CONFIG_PREEMPT_RT - it's shorter.
>
> - renamed CONFIG_PREEMPT_TIMING to CONFIG_CRITICAL_TIMING and 
>   introduced CONFIG_CRITICAL_IRQSOFF_TIMING to enable cli/sti timing.
>
>to create a -V0.7.21 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
>   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.21
>
>	Ingo
>
>  
>
When trying to patch my kernel i get following notice:
patching file include/linux/highmem.h
patch unexpectedly ends in middle of line
patch: **** unexpected end of file in patch
