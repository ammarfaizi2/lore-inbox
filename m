Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTBXQHP>; Mon, 24 Feb 2003 11:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTBXQHP>; Mon, 24 Feb 2003 11:07:15 -0500
Received: from bitmover.com ([192.132.92.2]:53200 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267221AbTBXQHI>;
	Mon, 24 Feb 2003 11:07:08 -0500
Date: Mon, 24 Feb 2003 08:17:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224161716.GC5665@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1630000.1046072374@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630000.1046072374@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:39:34PM -0800, Martin J. Bligh wrote:
> > The point being that there is a company generating $32B/year in sales and
> > almost all of that is in uniprocessors.  Directly countering your
> > statement that there is no margin in PC's.  They are making $2B/year in
> > profits, QED.
> 
> Which is totally irrelevant. It's the *LINUX* market that matters. What
> part of that do you find so hard to understand? 

OK, so you can't handle the reality that the server market overall doesn't
make your point so you retreat to the Linux market.  OK, fine.  All the
data anyone has ever seen has Linux running on *smaller* servers, not
larger.  Show me all the cases where people replaced 4 CPU NT boxes with
8 CPU Linux boxes.  

The point being that if in the overall market place, big iron isn't
dominating, you have one hell of a tough time making the case that the
Linux market place is somehow profoundly different and needs larger
boxes to do the same job.

In fact, the opposite is true.  Linux squeezes substantially more
performance out of the same hardware than the commercial OS offerings,
NT or Unix.  So where is the market force which says "oh, switching to
Linux?  Better get more CPUs".

> It makes IBM money, ergo they pay me. I enjoy doing it, ergo I work for
> them. Most of the work benefits smaller systems as well, ergo we get our
> patches accepted. So everyone's happy, apart from you, who keeps whining.

Indeed I do, I'm good at it.  You're about to find out how good.  It's
quite effective to simply focus attention on a problem area.  Here's
my promise to you: there will be a ton of attention focussed on the
scaling patches until you and anyone else doing them starts showing
up with cache miss counters as part of the submission process.

> So now we've slid from talking about bus traffic from fine-grained locking,
> which is mostly just you whining in ignorance of the big picture, to cache
> effects, which are obviously important. Nice try at twisting the
> conversation. Again.

You need to take a deep breath and try and understand that the focus of
the conversation is Linux, not your ego or mine.  Getting mad at me just
wastes energy, stay focussed on the real issue, Linux.

> > People care about performance, both scaling up and scaling down.  A lot of
> > performance changes are measured poorly, in a way that makes the changes
> > look good but doesn't expose the hidden costs of the change.  What I'm
> > saying is that those sorts of measurements screwed over performance in
> > the past, why are you trying to repeat old mistakes?
> 
> One way to measure those changes poorly would be to do what you were
> advocating earlier - look at one tiny metric of a microbenchmark, rather
> than the actual throughput of the machine. So pardon me if I take your
> concerns, and file them in the appropriate place.

You apparently missed the point where I have said (a bunch of times) 
run the benchmarks you want and report before and after the patch 
cache miss counters for the same runs.  Microbenchmarks would be 
a really bad way to do that, you really want to run a real application
because you need it fighting for the cache.  

> > My argument is different because every effort which has gone in the
> > direction you are going has ended up with a kernel that worked well on
> > big boxes and sucked rocks on little boxes.  And all of them started
> > with kernels which performed quite nicely on uniprocessors.
> 
> So you're trying to say that fine-grained locking ruins uniprocessor
> performance now? 

I've been saying that for almost 10 years, check the archives.

> You just don't get it, do you? Your head is so vastly inflated that you
> think everyone should run around researching whatever *you* happen to think
> is interesting. Do your own benchmarking if you think it's a problem.

That's exactly what I'll do if you don't learn how to do it yourself.  I'm
astounded that any competent engineer wouldn't want to know the effects of
their changes, I think you actually do but are just too pissed right now
to see it.  

> > Linux is a really fast system right now.  [etc]
> 
> Everyone. And we can do that, and make large systems work at the same time.
> Despite the fact you don't believe me. And despite the fact that you can't
> grasp the difference between the number 16 and the number 64.

See other postings on this one.  All engineers in your position have said
"we're just trying to get to N cpus where N = ~2x where we are today and
it won't hurt uniprocessor performance".  They *all* say that.  And they
all end up with a slow uniprocessor OS.  Unlike security and a number of
other invasive features, the SMP stuff can't be configed out or you end
up with an #ifdef-ed mess like IRIX.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
