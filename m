Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282212AbRL0UeG>; Thu, 27 Dec 2001 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286615AbRL0Ud4>; Thu, 27 Dec 2001 15:33:56 -0500
Received: from bitmover.com ([192.132.92.2]:18590 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S282212AbRL0Udp>;
	Thu, 27 Dec 2001 15:33:45 -0500
Date: Thu, 27 Dec 2001 12:33:44 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227123344.H25698@work.bitmover.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011227121033.F25698@work.bitmover.com> <Pine.LNX.4.33.0112271213210.1167-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0112271213210.1167-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 27, 2001 at 12:21:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 12:21:02PM -0800, Linus Torvalds wrote:
> 
> On Thu, 27 Dec 2001, Larry McVoy wrote:
> > On Thu, Dec 27, 2001 at 06:05:40PM +0000, Linus Torvalds wrote:
> > > Note that things like CVS do not help the fundamental problem at all.
> > > They allow automatic acceptance of patches, and positively _encourage_
> > > people to "dump" their patches on other people, and not act as real
> > > maintainers.
> >
> > Huh.  I'm not sure I understand this.  Once you accept a patch into the
> > mainline source, are these people still supposed to maintain that patch?
> 
> [Linus stuff]

But this didn't answer my question at all.  My question was why is this a 
problem related to a source management system?  I can see how to exactly
mimic what described Al doing in BK so if that is the definition of goodness,
the addition (or absence) of a SCM doesn't seem to change the answer.

I _think_ what you are saying is that an SCM where your repository is a 
wide open black hole with no quality control is a problem, but that's 
not the SCM's fault.  You are the filter, the SCM is simply an accounting/
filing system.

> > > I know that source control advocates say that using source control makes
> > > it easy to revert bad stuff, but that's simply not TRUE.  It's _not_
> > > easy to revert bad stuff.
> >
> > It's trivial to revert bad stuff if other stuff hasn't come to depend
> > on that bad stuff, assuming a reasonable SCM system.
> 
> Well, there's the other part to it - most bad stuff is just "random crap",
> and may not have any physical bad tendencies except to make the code
> uglier. Then, people don't even realize that they are doing things the
> wrong way, because they do cut-and-paste, or they just can't do things the
> sane way because the badness assumes a certain layout.
> 
> And THAT is where badness is actively hurtful, while not being buggy.
> Which is why I'd much rather have people work on maintenance, and not rely
> on the bogus argument of "we can always undo it".

No argument.  In fact, wild agreement.  I absolutely *hate* bad crap
being checked into the tree because when it is fixed later it obscures
the original reason for the addition of the code in the first place.
While we rarely reach it, I think we can agree it would be great if code
were checked in once and never modified again because it is perfect.
Obviously a pipe dream, but I think it is the sentiment you are expressing
- don't check in garbage, check in good stuff, and anything that makes
checking in garbage easier is a Bad Thing (tm).

Switching topics just slightly, isn't one of the main problems with SCM
systems that the end user does the merges rather than the maintainer?
Look at how you do it:

	a) release tree
	b) wait for patches
	c) weed through patches looking for good ones
	d) apply patches, which means merging in some cases
	e) repeat

but your typical SCM has the end user doing the merges, not the maintainer.
If you had an SCM system which allowed the maintainer to do all or some of
the merging, would that help?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
