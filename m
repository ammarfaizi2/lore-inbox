Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268828AbUJPT7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268828AbUJPT7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUJPT7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:59:43 -0400
Received: from brown.brainfood.com ([146.82.138.61]:8576 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S268817AbUJPT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:59:39 -0400
Date: Sat, 16 Oct 2004 14:59:36 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
In-Reply-To: <20041016193626.GB10626@elte.hu>
Message-ID: <Pine.LNX.4.58.0410161457410.1223@gradall.private.brainfood.com>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
 <20041016153344.GA16766@elte.hu> <Pine.LNX.4.58.0410161426020.1223@gradall.private.brainfood.com>
 <20041016193626.GB10626@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2004, Ingo Molnar wrote:

>
> * Adam Heath <doogie@debian.org> wrote:
>
> > > i have released the -U4 PREEMPT_REALTIME patch:
> > >
> > >    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4
> > >
> > > this is a fixes-only release, and it is still experimental code.
> >
> > Few stack dumps now.
>
> these are normal, they are the PREEMPT_TIMING traces which get printed
> every time the kernel measures a new latency maximum. The stack dumps
> are done to make it easier to identify which place too that long of a
> delay and why. (if LATENCY_TRACE is enabled too then the last latency
> and its trace can also be found in /proc/latency_trace.)
>
> after bootup it makes sense to reset the maximum:
>
> 	echo 10 > /proc/sys/kernel/preempt_max_latency
>
> because during bootup there are a number of latencies that are one-time
> only.

So, I did that, and immediately started getting more stack dumps.  Are these
things that are interesting, or only informational?
