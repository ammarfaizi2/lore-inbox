Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290251AbSAXEVa>; Wed, 23 Jan 2002 23:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290253AbSAXEVK>; Wed, 23 Jan 2002 23:21:10 -0500
Received: from [216.70.178.182] ([216.70.178.182]:4736 "EHLO mail.xinetd.com")
	by vger.kernel.org with ESMTP id <S290251AbSAXEVJ>;
	Wed, 23 Jan 2002 23:21:09 -0500
Date: Wed, 23 Jan 2002 20:20:46 -0800 (PST)
From: Glendon Gross <gross@xinetd.com>
To: Robert Love <rml@tech9.net>
cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Subject: Re: Low latency for recent kernels
In-Reply-To: <1011845875.7028.63.camel@phantasy>
Message-ID: <Pine.LNX.4.21.0201232020150.432-100000@mail.xinetd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this patch available for 2.5.2 ? or is it already part of the tree?

On 23 Jan 2002, Robert Love wrote:

> On Wed, 2002-01-23 at 22:48, Dan Maas wrote:
> 
> > Two situations where I would expect low-latency/preemption to have a
> > positive effect on responsiveness are 1) when the system is under heavy CPU
> > and disk load (e.g. kernel compile); due to the interactive tasks being able
> > to run earlier/more often, and 2) when performing UI operations that depend
> > on tight synchronization between X/the WM/the X client, particularly opaque
> > window resizing. (my theory is that low-latency/preemption results in the
> > CPU switching more rapidly or evenly among these processes, reducing the
> > perceptible "lag" between the client window and its WM frame)
> 
> This is exactly the area preempt/low-latency helps and I think your
> theory is pretty much dead on.
> 
> With preempt-kernel, ideally, an interactive task finds itself runnable
> like this: user event causes interrupt, interrupt sets need_resched, on
> return from interrupt we cause a preemption of current task (which can
> happen whether task is in kernel or userland, now), and schedule the
> interactive task onto the CPU.
> 
> This leads to better scheduling fairness and short scheduling latency.
> 
> If you or Havoc are interested in any tests or further work with the
> preemptive kernel, I'd be more than willing.  Hey, I use GNOME ;)
> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

