Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVBQPTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVBQPTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVBQPOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:14:23 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:4801 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262270AbVBQPNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:13:34 -0500
Date: Thu, 17 Feb 2005 10:13:26 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: "David S. Miller" <davem@davemloft.net>, mgross@linux.intel.com,
       linux-kernel@vger.kernel.org, Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
In-Reply-To: <20050217075713.GB21621@elte.hu>
Message-ID: <Pine.LNX.4.58.0502171002420.14536@localhost.localdomain>
References: <200502141240.14355.mgross@linux.intel.com>
 <200502141429.11587.mgross@linux.intel.com> <20050215104153.GB19866@elte.hu>
 <200502151006.44809.mgross@linux.intel.com> <20050216051645.GB15197@elte.hu>
 <20050216081143.50d0a9d6.davem@davemloft.net>
 <Pine.LNX.4.58.0502161242180.14526@localhost.localdomain> <20050217075713.GB21621@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Damn! I'm doing this from out of town and my pine setup had a reply to to
another email account, and I didn't read this before I sent my previous
response (so Please ignore it!)

On Thu, 17 Feb 2005, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > See net/core/dev.c:softnet_data
> >
> > How about a design to put softirq's into domains. [...]
>
> just to make sure that the context of this discussion is not lost to
> David and other readers of lkml. We are not redesigning softirqs in any
> way, shape or form for the normal kernel - there they remain what they
> are.
>
> This discussion is about seemless (automatic) extensions/modifications
> to the softirq concept on PREEMPT_RT, for latency reduction purposes.
> PREEMPT_SOFTIRQS is already such an extension.
>

I'm only working on your PREEMPT_RT extension, so I wasn't thinking about
the mainline kernel.

But I'll ask again from this context. What is the plan for softirqs on the
PREEMPT_RT kernel? Are you going to thread them? Otherwise, what other way
can you preempt different softirqs?

I understand that the design of softirqs will not change for the mainline
kernel, but what changes are going to be made wrt PREEMPT_RT? If they are
going to be threaded, then grouping them would not be too much of a
problem with simple #ifdefs around the code and keep the mainline
untouched.

I may be just confused, so please enlighten me :-)

Thanks,

-- Steve

