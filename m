Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292236AbSBBGRc>; Sat, 2 Feb 2002 01:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292237AbSBBGRX>; Sat, 2 Feb 2002 01:17:23 -0500
Received: from bitmover.com ([192.132.92.2]:30082 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292236AbSBBGRI>;
	Sat, 2 Feb 2002 01:17:08 -0500
Date: Fri, 1 Feb 2002 22:17:07 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@trommello.org>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Message-ID: <20020201221707.I27081@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <landley@trommello.org>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Keith Owens <kaos@ocs.com.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de> <20020202001056.UXDI10685.femail14.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020202001056.UXDI10685.femail14.sdc1.sfba.home.com@there>; from landley@trommello.org on Fri, Feb 01, 2002 at 03:47:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 03:47:16PM -0500, Rob Landley wrote:
> That's my impression, anyway.  (A few years out of date now.)  My experience 
> with the source control system was that it DID have the complete revision 
> history in it going back to the 1980's, but it was far more work than it was 
> worth to try to mine through it to find something ...

bk revtool
double click on the last rev, brings up an annotated listing,
click on a line, brings up the checkin comments for that line,
double click on a line, brings up a changeset viewer showing the
entire patch which contained that line.

Now tell me, Rob, wouldn't you find that useful?  I find it useful,
I find it extremely useful, I can fix bugs a factor of 10 (at least)
faster with it than without.  Not having it is like not having ctags,
how the hell do you find anything?

> specifically looking to place blame and prove something wasn't YOUR fault.  

Only losers need to go look to place blame.  Programmers fix bugs.  This
information dramatically improves your ability to fix bugs.  If you
programmed more and talked less, you might understand this concept.

> I.E. yes, I think we honestly do want an easy way to limit the granularity of 
> propogated diffs.  

So suppose I'm joe developer and I make 10 changesets to add some feature.
Somewhere in there I caused a problem.  The changesets have been collapsed
so I now have to wade through all of them to figure out what the problem is.
If I had all of them, I could 

	bk clone
	while true
	do
		make
		test_for_bug || break
		bk undo -fr+
	done

which quickly walks through all of them and finds me exactly the one that
caused the problem.  

The more I collapse, the harder this is.  But wait, you say, if BK lety
me do it both ways, the original developer has all this detail.  Great,
that means we took a system that could let the whole world figure out the
problem and we made it so only one guy can do it fast.  Not real smart.

I'm sympathetic to the "wait, I made this changeset and then I found
another bug" problem and we have a command that lets you reedit a
changeset.  And we're talking with Linus about making that even more
flexible.  But the rules are you can only change history on things you
haven't propogated.

If you want to help make BitKeeper better, it would be a lot more
productive if you used it and figured out how it really works instead of
critizing how you think it works.  It's a lot closer to what you want than
you think it is, and it is much closer than any other system in the world.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
