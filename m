Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291327AbSBGV0R>; Thu, 7 Feb 2002 16:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291332AbSBGV0I>; Thu, 7 Feb 2002 16:26:08 -0500
Received: from bitmover.com ([192.132.92.2]:50654 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291324AbSBGVZ7>;
	Thu, 7 Feb 2002 16:25:59 -0500
Date: Thu, 7 Feb 2002 13:25:58 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Lord <lord@regexps.com>
Cc: jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207132558.D27932@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202072306.PAA08272@morrowfield.home>; from lord@regexps.com on Thu, Feb 07, 2002 at 03:06:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Arch will certainly need to be tuned for kernel hackers and perhaps
> customized.  

{Note: I'm not going be drawn into a BK is better or worse than arch
discussion.  It's not fair to Tom, and it would really need to be a BK now
vs arch in 5 years discussion to be remotely apples to apples.  So here
are my thoughts and then I'll leave this to the rest of you to discuss.}

An interesting experiment would be to take every kernel revision,
including all the pre-patches, and import it into arch and report the
resulting size of the repository and the time to generate each version
of the tree from that repository.  I suspect that this will demonstrate
the most serious issue that I have with the arch design.

In essence arch isn't that different from RCS in that arch is
fundamentally a diff&patch based system with all of the limitations that
implies.  There are very good reasons that BK, ClearCase, Aide De Camp,
and other high end systems, are *not* diff&patch based revision histories,
they are weave based.  Doing a weave based system is substantially
harder but has some nice attributes.  Simple things like extracting any
version of the file takes constant time, regardless of which version.
Annotated listings work correctly in the face of multiple branches and
multiple merges.  The revision history files are typically smaller,
and are much smaller than arch's context diff based patches.

But most importantly, BK at least, has great merge tools.  At the end of
the day, what most people spend their time on is merging.  Everything else
is just accounting and how the system does that is interesting to the
designers and noone else.  What users care about is how much time they
spend merging.  It's technically impossible to get arch or CVS or RCS or
any diff&patch based system to give you the same level of merge support.

On the other hand, I like parts of arch.  I have to like the distributed
repository nature of it, that's a clear reimplementation of BitKeeper
and Teamware.  I've been waiting for someone to do that for 10 years.
If arch were weave based, had good merge tools, was started 6 years ago,
and had a commercial company backing it, BitKeeper probably wouldn't
exist, we'd be using arch and working on Linux clusters.

Looking forward, I wonder about money issues, as politically incorrect
that may be.  We spent millions developing BitKeeper with no end in sight.
Tom has done a lot of work, but he has to eat as well.  I doubt very
much that arch will ever generate enough revenue to pay for its ongoing
development.  Companies simply won't pay for a product in this space
if they can get it for free.  And the problem with that is there are an
endless number of corner cases which need to be handled, aren't fun, and
aren't going to happen for free.  That means arch has a natural growth
path, it will evolve to a certain point much like CVS has, and then stop.
It will be a useful point, but it won't be remotely close to covering
the same problem space that ClearCase or BK or any other professional
SCM system does.

Before you yell at me, remember that source management is not the same
as the kernel.  Everyone has to use the kernel, the computer doesn't work
without it.  Take that set of people and remove everyone who doesn't use
source management.  Out of a potential space of billions of people, you
are left with a market of about .5 - 2 million, world wide.  And there
are 300 SCM systems fighting over that space.  The top 3 have 50% of the
space.  So 297 systems fighting over maybe a million users.  That's 3300
users per system.  OK, so if each of those people were willing to pay
$500 for arch support/whatever, that's a total of 1.6 million dollars.
Which isn't remotely close enough to get the job done.  And don't forget
that those people have to volunteer that money, it can't be pried out
of them.

It's just math.  Projects that aren't universally used have a much harder
time getting funding than projects that everyone uses.  It doesn't matter
what the value is to you, it matters what the costs are to the developers.
This is why microsoft is so rich, they build apps that the masses use.
It's also why clearcase+clearquest is $8000/seat.  It's not because
that's what the value is, it's because that's what the cost has to be
or Rational starts to die.

So before you start talking about support contracts, and grants, and
whatever, realize that the pool of people interested in paying those
dollars is very small.  Are _you_ going to send Tom $500?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
