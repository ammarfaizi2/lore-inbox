Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbTCJAWC>; Sun, 9 Mar 2003 19:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbTCJAWC>; Sun, 9 Mar 2003 19:22:02 -0500
Received: from bitmover.com ([192.132.92.2]:50590 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262682AbTCJAWB>;
	Sun, 9 Mar 2003 19:22:01 -0500
Date: Sun, 9 Mar 2003 16:32:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Zack Brown <zbrown@tumblerings.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Thoughts about ideal kernel SCM
Message-ID: <20030310003233.GC29789@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Zack Brown <zbrown@tumblerings.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v$14m$1@penguin.transmeta.com> <20030308225252.GA23972@renegade> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade> <20030310000233.GS3917@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310000233.GS3917@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What am I missing?

Nothing that a half of decade of work wouldn't fill in :)

More seriously, lots.  I keep saying this and people keep not hearing it,
but it's the corner cases that get you.  You seem to have a healthy grasp
of the problem space on the surface but in reading over your stuff, you 
aren't even where I was before BK was started.  That's not supposed to be
offensive, just an observation.  As you try out the ideas you described
you'll find that they don't work in all sorts of corner cases and the 
problem is that there are a zillion of them.  And the solutions have
this nasty habit of fighting with each other, you solve one problem
and that creates another.

The thing we've found is that this problem space is much bigger than one
person can handle, even an exceptionally talented person.  The number of
variables are such that you can't do it in your head, you need to have a
muse for each area and both of you have to be thinking about it full time.

This isn't a case of "oh, I get it, now I'll write the code".  It's a
case of "write the code, deploy the code, get taught that it didn't work,
get the insight from that, write new code, repeat".  And the problems are
such that if you aren't on them all the time then you work very slowly,
99% of the work is recreating the state you had in your brain the last
time you were here.  

I strongly urge you to wander off and talk to people who are actually
writing code for real users.  Arch, SVN, CVS, whatever.  Get deeply
involved and understand their choices.  Personally, I'd suggest the SVN
guys because I think they are the most serious, they have a team which
has been together for a long time and thought hard about it.  On the
other hand, Arch is probably closer to mimicing how development really
happens in the real world, in theory, at least, it can do better than BK,
it lets you take out of order changesets and BK does not.  But it is light
years behind SVN in terms of actually working and being a real product.
SVN is almost there, they are self hosting, they eat their own dog food,
Arch is more a collection of ideas and some shell scripts.  From SVN,
you're going to learn more of the hard problems that actually occur,
but Arch might be a better long term investment, hard to say.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
