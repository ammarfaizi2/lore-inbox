Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290306AbSAXVQb>; Thu, 24 Jan 2002 16:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290304AbSAXVQT>; Thu, 24 Jan 2002 16:16:19 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:10764 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290306AbSAXVQI>; Thu, 24 Jan 2002 16:16:08 -0500
Message-ID: <3C507989.5D47D392@linux-m68k.org>
Date: Thu, 24 Jan 2002 22:15:53 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Daniel Phillips <phillips@bonn-fries.net>, Robert Love <rml@tech9.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <1011650506.850.483.camel@phantasy> <20020121165659.A20501@hq.fsmlabs.com> <E16SqOY-0001mL-00@starship.berlin> <20020124081950.A5668@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

I know you're not talking to me (you even removed me and only me from
the Cc list...) and personally I don't care, but other people might get
the impression you had something to say.

> > The patch itself is simple, so this must be an extended interpretation of the 
> > word 'complex'.
> 
> I'm at a loss here. You seem to be arguing that
> there there is a relationship between the complexity of a patch
> that changes the entire synchronization assumption of the
> kernel and the complexity of the result. But that seems
> unbelievable. Is there some component of your argument I've missed?

Which "entire synchronization assumption"? It changes timing
assumptions, which sometimes are used for synchronization. If something
breaks because of this, it was already broken before.
Maybe you could explain this "relationship" in a bit more detail?

> It's also worth pointing out that every use of cpu-specific information
> is dangerous if preemption is extended to smp.
>         x = smp_processor_id();
>         //get preempted
>         do_something(memslab[x]); // used to be safe since only current can
>                                 // do this.

This is a well known problem, which is also fixable. It's also known,
that these fixes would have a larger impact on the kernel, for that
reason preempt for smp is not a real option right now, so that it is
outside the scope of this discussion (or what's left it).

> > >     It seems to lead to a requirement for inheritance
> >
> > I don't know about that.  From the (long) thread above, it looks like you
> > haven't successfully proved the assertion that -preempt introduces any new
> > inheritance requirement.
> 
> Oliver cited the trivial case. He was ignored.

I really tried to find a detailed explanation of this case, but I
haven't found anything, it's possible I missed, so I'd be happy about
any pointer. From the hints I found that case seemed rather unlikely and
assuming a really bad scheduler.

> I've heard similar arguments in favor of aromatherapy and Scientology.

Now we are compared to this. Nice "arguments". :-(

> What's amazing about all the arguments in favor of preemption is that we
> don't see any published numbers of the obvious application: a periodic
> SCHED_FIFO process. We've done these experiments and the results are
> _dismal_.

url?

> Even ignoring this, the repeated publication of numbers showing that
> Andrew's patches get better results and the repeated statement by
> Andrew that the hard part of latency reduction
> is _not_ solved by preemption alone
> is continually met with repetitions of the same unsubstantiated chorus:
>         But it is easier to maintain

"repeated statement"? I've seen Andrew stating it once, repeated by you
and here is my (unanswered) response
http://marc.theaimsgroup.com/?l=linux-kernel&m=101100365432615&w=2.

> > As far as arguments go, your main points don't seem to be rooted in firm
> > ground at all.  On the other hand, the proponents of this patch have
> > compelling arguments: it makes Linux feel smoother, it makes certain tests
> > run faster, it doesn't slow anything down measurably, it's stable and so on.
> > I even explained why it does what it does.  I don't understand why you're so
> > vehemently opposed to this, especially as it's a config option.
> 
> What you proposed is a
> claimed explanation of why a task that experienced regular unfixable
> latencies of multiple milliseconds waiting for I/O would have additional
> latencies possibly reduced by some unknown amount. You failed to make a
> case that this is either something that actually happens or that it would
> ever make any difference.

You happily ignore the cases where it makes a difference. There might be
purely empirical, but they exist and you make no attempt at explaining
them.

> I've argued that it is based on a very bad design premise.

"Arguing" means for me to come up with arguments, which are really rare
from you. Maybe you can surprise us with some real arguments? I'd be
even happy about urls. So far I have only seen statements with very thin
backing. If I missed something, I still have an open offer for an
apology.

bye, Roman
