Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268131AbTBXGsW>; Mon, 24 Feb 2003 01:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268177AbTBXGsW>; Mon, 24 Feb 2003 01:48:22 -0500
Received: from bitmover.com ([192.132.92.2]:57537 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268131AbTBXGsU>;
	Mon, 24 Feb 2003 01:48:20 -0500
Date: Sun, 23 Feb 2003 22:58:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224065826.GA5665@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48940000.1046063797@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 09:16:38PM -0800, Martin J. Bligh wrote:
> Ummm ... now go back to what we were actually talking about. Linux margins. 
> You think a significant percentage of the desktops they sell run Linux?

The real discussion was the justification for scaling work beyond the
small SMPs.  You tried to make the point that there is no money in PC's so
any work to scale Linux up would help hardware companies stay financially
healthy.  I and others pointed out that there is indeed a pile of money
in PC's, that's vast majority of the hardware dell sells.  They don't
sell anything bigger than an 8 way and they only have one of those.
We went on to do the digging to figure out that it's impossible that
dell makes a substantial portion of their profits from the big servers.

The point being that there is a company generating $32B/year in sales and
almost all of that is in uniprocessors.  Directly countering your statement
that there is no margin in PC's.  They are making $2B/year in profits, QED.

Which brings us back to the point.  If the world is not heading towards
an 8 way on every desk then it is really questionable to make a lot of
changes to the kernel to make it work really well on 8-ways.  Yeah, I'm
sure it makes you feel good, but it's more of a intellectual exercise than
anything which really benefits the vast majority of the kernel user base.

> > Ahh, now we're getting somewhere.  As soon as we get anywhere near real
> > numbers, you don't want anything to do with it.  Why is that?
> 
> Because I don't see why I should waste my time running benchmarks just to
> prove you wrong. I don't respect you that much, and it seems the
> maintainers don't either. When you become somebody with the stature in the
> Linux community of, say, Linus or Andrew I'd be prepared to spend a lot
> more time running benchmarks on any concerns you might have.

Who cares if you respect me, what does that have to do with proper
engineering?   Do you think that I'm the only person who wants to see
numbers?  You think Linus doesn't care about this?  Maybe you missed
the whole IA32 vs IA64 instruction cache thread.  It sure sounded like
he cares.  How about Alan?  He stepped up and pointed out that less
is more.  How about Mark?  He knows a thing or two about the topic?
In fact, I think you'd be hard pressed to find anyone who wouldn't be
interested in seeing the cache effects of a patch.

People care about performance, both scaling up and scaling down.  A lot of
performance changes are measured poorly, in a way that makes the changes
look good but doesn't expose the hidden costs of the change.  What I'm
saying is that those sorts of measurements screwed over performance in
the past, why are you trying to repeat old mistakes?

> > Wow.  Compelling.  "It is so because I say it is so".  Jeez, forgive me 
> > if I'm not falling all over myself to have that sort of engineering being
> > the basis for scaling work.
> 
> Ummm ... and your argument is different because of what? You've run some
> tiny little microfocused benchmark, seen a couple of bus cycles, and
> projected the results out? 

My argument is different because every effort which has gone in the
direction you are going has ended up with a kernel that worked well on
big boxes and sucked rocks on little boxes.  And all of them started
with kernels which performed quite nicely on uniprocessors.

If I was waving my hands and saying "I'm an old fart and I think this
won't work" and that was it, you'd have every right to tell me to piss
off.  I'd tell me to piss off.  But that's not what is going on here.
What's going on is that a pile of smart people have tried over and over
to do what you claim you will do and they all failed.  They all ended up
with kernels that gave up lots of uniprocessor performance and justified
it by throwing more processors at that problem.  You haven't said a 
single thing to refute that and when challenged to measure the parts
which lead to those results you respond with "nah, nah, I don't respect
you so I don't have to measure it".  Come on, *you* should want to know
if what I'm saying is true.  You're an engineer, not a marketing drone,
of course you should want to know, why wouldn't you?

Linux is a really fast system right now.  The code paths are short and
it is possible to use the OS almost as if it were a library, the cost is
so little that you really can mmap stuff in as you need, something that
people have wanted since Multics.  There will always be many more uses
of Linux in small systems than large, simply because there will always
be more small systems.  Keeping Linux working well on small systems is
going to have a dramatically larger positive benefit for the world than
scaling it to 64 processors.  So who do you want to help?  An elite
few or everyone?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
