Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbUJZBH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUJZBH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUJZBH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:07:26 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:48871 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261837AbUJZBHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:07:11 -0400
Date: Mon, 25 Oct 2004 18:01:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041026010141.GA15919@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>, akpm@osdl.org
References: <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410252350240.17266@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 02:06:54AM +0200, Roman Zippel wrote:
> bk makes it in first 
> place easier to apply and merge a lot of patches, but patches still have 
> to be written, reviewed and maintained. The ability to handle big amounts
> of patches includes also the possibility to merge a lot of crap. What 
> keeps up the general quality? 

http://www.bitkeeper.com/press/newsforgearticle.html - see part 2, the
long answer on development models.  It goes into detail about how it 
can work.

> There is a certain license problem, which very effectly keeps out a lot of 
> those people, who might have other ideas for managing the kernel sources 
> and improving the development process. 

Well, you don't use BK and Andrea doesn't use BK and the arch developers
don't use BK and you have all had at least 3 years to do something better.

> The "protecting IP" talk is 
> complete bullshit, one doesn't need direct access to figure out how it 
> works. There are a few free SCM systems out there, that use very similiar 
> mechanism, they of course still need to work out the details, but it's no 
> magic and just takes times. 

There is a lot more magic in there than you believe and the fact that 
nobody has replicated BK in the last 5 years gives us some reason to
believe that the license is actually working.  

While there is some fairly profound stuff buried inside of BK, it's the
nasty little corner cases which are the hard work.  If I had to divide
up the work I think that the corner cases are more than 80% of the work.
You are mistakenly assuming that the way BK stores the data, or does
merges, or synchronizes is what we think is worth protecting, and you
are pretty much wrong.  Yes, that stuff is interesting to an engineer
because it is something you can describe, it's like math.  But the math
is easy compared to the polishing.

The hard part is all the knowledge about all the little things which go
wrong and how to fix them.  It's relatively easy to make a system which
looks like BK, there are several out there.  They all fall over as soon
as you try and stress them in any way.  The fact that BK doesn't is what
is hard and yes, it *is* worth protecting, we worked very hard to make
BK work for you and we think it is perfectly reasonable that you either
agree to not rip us off or you don't get to use BK.

Our license is not one iota less reasonable than the GPL.  What about all
those people who want to use your work and not give back?  How about that
guy who wants a BSD licensed Linux, for the obvious reasons?  You were all
outraged that that guy would want to rip off your work, why is it so darned
hard for you to see that we are equally outraged when you want to use our
work for free and rip it off?  If you really were about just helping the
world it wouldn't bother you in the slightest to offer up a BSD licensed
Linux kernel.  Admit it, you want to keep on playing in your playground.
That's fine, we want the same thing.  We are both using licensing to 
accomplish our goals.

> Being able to import the kernel repository 
> into them would be a great way to test them, but unfortunately all the 
> free testing is reserved for bk, as usual the winner takes it all and the 
> losers eat the dust, isn't that how open source works...?

Huh?  We make the CVS exported tree available nightly and have been doing
so for more than a year and in spite of all the dire predictions that it 
wouldn't last it's still there.

There are 23,000 commits in the BK2CVS 2.5/2.6 tree.  All on kernel.org
for your importing pleasure complete with all the checkin comments and
other history.

You can import to your hearts content and people have, only to find that
their system falls over dead when they do.  

> Blaming Andrea for this mess is of course easy, but it doesn't solve 
> anything and misses the point, the only thing Andrea is to blame for is 
> that he is not very diplomatic, but that's unfortunately a trait seldom 
> found under hackers. Ignoring the problems and silencing the critics 
> doesn't solve anything and I would be more concerned if nobody would 
> object anymore, when Larry is on one of his ego trips.

Nobody is "blaming Andrea for this mess", all that was being asked was
that he treat other people how he would like to be treated.  What Andrea
and you are doing is similar to that guy asking for a BSD licensed Linux
kernel and continuing to do so at every opportunity.  Wouldn't that get 
a bit old?

As for my ego, my friend, don't flatter yourself that I would come to
this forum to inflate my ego in the unlikely event I felt it needed a
tuneup.  You'd have to be insane to think that hanging out here and
getting crapped on for 5 years is an ego inflating process.  Sheesh.
Who are you kidding?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
