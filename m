Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTBYOwe>; Tue, 25 Feb 2003 09:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTBYOwe>; Tue, 25 Feb 2003 09:52:34 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:6021 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S267070AbTBYOwd>; Tue, 25 Feb 2003 09:52:33 -0500
Date: Tue, 25 Feb 2003 06:59:12 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: yodaiken@fsmlabs.com, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, lm@work.bitmover.com,
       mbligh@aracnet.com, davidsen@tmr.com, greearb@candelatech.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225145912.GA4162@gnuppy.monkey.org>
References: <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com> <20030224085031.GP10411@holomorphy.com> <20030224091758.A11805@hq.fsmlabs.com> <20030224231341.GQ10411@holomorphy.com> <20030224162754.A24766@hq.fsmlabs.com> <20030225021736.GB4507@gnuppy.monkey.org> <1046187058.4096.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046187058.4096.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 03:30:59PM +0000, Alan Cox wrote:
> Nothing is conceptually obvious. Thats the difference between 'science'
> and engineering. Our bridges have to stay up.

Yes, I absolutely agree with this. It shouldn't be the case where one is
over the other, they should have a complementary relationship.

> > It's about getting relationship inside the kernel to respect and be
> > controllable by the scheduler in some formal manner, not some random
> > not-so-well-though-out hack of the day.
> 
> Prove it, compute the bounded RT worst case. You can't do it. Linux, NT,
> VMS and so on are all basically "armwaved real time". Now for a lot of
> things armwaved realtime is ok, one 'click' an hour on a phone call
> from a DSP load miss isnt a big deal. Just don't try the same with
> precision heavy machinery.
> 
> Its not a lack of competence, we genuinely don't yet have the understanding
> in computing to solve some of the problems people are content to armwave
> about.
> 
> If I need extremely high provable precision, Victor's approach is right, if
> I want armwaved realtimeish behaviour with a more convenient way of working
> then Victor's approach may not be the best.

I spoke to some folks related to CMU's RTOS group about a year ago and was
influenced by their preemption design in that they claimed to get tight RT
latency characteristics by what seems like some mild changes to the Linux
kernel. I recently start to investigate their stuff, took a clue from them
and became convince that this approach was very neat and elegant. MontaVista
apparently uses this approach over other groups that run Linux as a thread
in another RT kernel. Whether this, static analysis tools doing rate{deadline}-monotonic
analysis and scheduler "reservations" (born from that RT theory I believe)
are unclear to me at this moment. I just find this particular track neat
and reminiscent of some FreeBSD ideals that I'd like to see fully working in
an open source kernel.

Top level link to many papers:
	http://linuxdevices.com/articles/AT6476691775.html

A paper I've take interest in recently from the top-level link:
	http://www.linuxdevices.com/articles/AT6078481804.html

People I originally talked to that influence my view on this:
	http://www-2.cs.cmu.edu/~rajkumar/linux-rk.html

> Its called engineering. There are multiple ways to build most things, each
> with different advantages, there are multiple ways to model it each with
> more accuracy in some areas. Knowing how to use the right tool is a lot 
> more important than having some religion about it.

Yes, I agree. I'm not trying to make a religious assertion and I don't
function that way. I just want things to work smoother and explore some
interesting ideas that I think eventually will be highly relevant to a
very broad embedded arena.

bill
 
