Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTBXQjC>; Mon, 24 Feb 2003 11:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTBXQjC>; Mon, 24 Feb 2003 11:39:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30657 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265523AbTBXQjA>; Mon, 24 Feb 2003 11:39:00 -0500
Date: Mon, 24 Feb 2003 08:49:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <12680000.1046105345@[10.10.2.4]>
In-Reply-To: <20030224161716.GC5665@work.bitmover.com>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmast
 er.ca> <1510000.1045942974@[10.10.2.4]>
 <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]>
 <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]>
 <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]>
 <20030224065826.GA5665@work.bitmover.com> <1630000.1046072374@[10.10.2.4]>
 <20030224161716.GC5665@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The point being that there is a company generating $32B/year in sales
>> > and almost all of that is in uniprocessors.  Directly countering your
>> > statement that there is no margin in PC's.  They are making $2B/year in
>> > profits, QED.
>> 
>> Which is totally irrelevant. It's the *LINUX* market that matters. What
>> part of that do you find so hard to understand? 
> 
> OK, so you can't handle the reality that the server market overall doesn't
> make your point so you retreat to the Linux market.  OK, fine.  All the

Errm. no. That was the conversation all along - you just took some remarks
out of context

> The point being that if in the overall market place, big iron isn't
> dominating, you have one hell of a tough time making the case that the
> Linux market place is somehow profoundly different and needs larger
> boxes to do the same job.

Dominating in terms of volume? No. My postion is that Linux sales for
hardware companies make more money on servers than desktops. We're working
on scalability ... that means CPUs, memory, disk IO, networking,
everything. That improves both the efficiency of servers ... "large
machines" (which your original message had as, and I quote, "4 or more CPU
SMP machines"), 2x and even larger 1x machines. If you're being more
specific as to things like NUMA changes, please point to examples of
patches you think degrades performance on UP / 2x or whatever.

> Indeed I do, I'm good at it.  You're about to find out how good.  It's
> quite effective to simply focus attention on a problem area.  Here's
> my promise to you: there will be a ton of attention focussed on the
> scaling patches until you and anyone else doing them starts showing
> up with cache miss counters as part of the submission process.

Here's my promise to you: people listen to you far less than you think, and
our patches will continue to go into the kernel.
 
>> So now we've slid from talking about bus traffic from fine-grained
>> locking, which is mostly just you whining in ignorance of the big
>> picture, to cache effects, which are obviously important. Nice try at
>> twisting the conversation. Again.
> 
> You need to take a deep breath and try and understand that the focus of
> the conversation is Linux, not your ego or mine.  Getting mad at me just
> wastes energy, stay focussed on the real issue, Linux.

So exactly what do you think is the problem? it seems to keep shifting
mysteriously. Name some patches that got accepted into mainline ... if
they're broken, that'll give us some clues what is bad for the future, and
we can fix them.

>> One way to measure those changes poorly would be to do what you were
>> advocating earlier - look at one tiny metric of a microbenchmark, rather
>> than the actual throughput of the machine. So pardon me if I take your
>> concerns, and file them in the appropriate place.
> 
> You apparently missed the point where I have said (a bunch of times) 
> run the benchmarks you want and report before and after the patch 
> cache miss counters for the same runs.  Microbenchmarks would be 
> a really bad way to do that, you really want to run a real application
> because you need it fighting for the cache.  

One statistic (eg cache miss counters) isn't the big picture. If throughput
goes up or remains the same on all machines, that's what important.
 
>> So you're trying to say that fine-grained locking ruins uniprocessor
>> performance now? 
> 
> I've been saying that for almost 10 years, check the archives.

And you haven't worked out that locks compile away to nothing on UP yet? I
think you might be better off pulling your head out of where it's currently
residing, and pointing it at the source code.

>> You just don't get it, do you? Your head is so vastly inflated that you
>> think everyone should run around researching whatever *you* happen to
>> think is interesting. Do your own benchmarking if you think it's a
>> problem.
> 
> That's exactly what I'll do if you don't learn how to do it yourself.  I'm
> astounded that any competent engineer wouldn't want to know the effects of
> their changes, I think you actually do but are just too pissed right now
> to see it.  

Cool, I'd love to see some benchmarks ... and real throughput numbers from
them, not just microstatistics.
 
> See other postings on this one.  All engineers in your position have said
> "we're just trying to get to N cpus where N = ~2x where we are today and
> it won't hurt uniprocessor performance".  They *all* say that.  And they
> all end up with a slow uniprocessor OS.  Unlike security and a number of
> other invasive features, the SMP stuff can't be configed out or you end
> up with an #ifdef-ed mess like IRIX.

Try looking up "abstraction" in a dictionary. Linus doesn't take #ifdef's
in the main code.

M.
