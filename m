Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290882AbSAaDwZ>; Wed, 30 Jan 2002 22:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290905AbSAaDwF>; Wed, 30 Jan 2002 22:52:05 -0500
Received: from bitmover.com ([192.132.92.2]:63149 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290882AbSAaDvz>;
	Wed, 30 Jan 2002 22:51:55 -0500
Date: Wed, 30 Jan 2002 19:51:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@trommello.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130195154.R22323@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Eli Carter <eli.carter@inet.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C586C8D.2C100509@inet.com> <20020130231701.FKGV22669.femail15.sdc1.sfba.home.com@there> <20020130175729.N22323@work.bitmover.com> <20020131031113.KFXH25423.femail46.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020131031113.KFXH25423.femail46.sdc1.sfba.home.com@there>; from landley@trommello.org on Wed, Jan 30, 2002 at 10:12:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh.  OK, I'm taking one more pass at trying to get you to see the light
and then I give up.  You need to understand that you haven't begun to
understand the problem, that you need to think a lot more before speaking,
and that it's really rude to shoot down a system that you haven't even
managed to through the basics of "hello world".  Food for thought.

On Wed, Jan 30, 2002 at 10:12:20PM -0500, Rob Landley wrote:
> The inflexibility of CVS relative to simply applying or reversing patches to 
> a source tree on disk is a documented reason Linus doesn't use CVS.  Don't 
> compare to CVS, compare to what Linus is currently using.  Beating a straw 
> man doesn't HELP.

Go read the archives, patch import/export is not ever, to the best of 
my knowledge, mentioned as a reason for Linus not liking CVS.  It's way
down on the issues list.  File renames, repository hierarchies, work
flow, reproducibility, I've talked with Linus about all of those as issues
but patch import/export never came up.  And CVS isn't remotely as good as
BK at that.  

> > The problem is extracting stuff out of the middle which
> > has already been built upon for more stuff.  How would you propose solving
> > that problem because that is the problem statement?
> 
> I'm not quite sure how Linus does this, but how I'd do it is [a really 
> complicated solution based on patches that won't work]

Think.  What you are describing is basically what Linus does today.  And
noone, including you, is happy.  You're the guy who started this thread.

> > If someone sends Linus a patch, he checks into BK or CVS or whatever,
> > he then gets 5 other patches and applies them in BK/CVS, and THEN he
> > wants to take out the first patch, how would you suggest we do that?
> 
> If the patch no longer unapplies cleanly, then a reversed patch to take it 
> out may have to be applied to the tree.  

Great, now we're getting somewhere.  You can take out a patch in
BK, including old ones way back in time, with a "bk cset -x<rev>".
Works great and no anti-patch is needed, so it's actually better than
what you described.

However, what you described *completely* misses the point.  Linus isn't
asking for an anti-patch, he doesn't want the bad patch in the revision
history at all.  He wants to be able to go backwards, across revisions,
and remove stuff in the middle.  He doesn't want the checkin comments,
he doesn't want the data, he wants no sign the patch was ever in the
revision history.

Do you start to see the problem?  You were yelling and screaming 
"BitKeeper sucks because it can't take a patch out" when in fact
it can do exactly what you said it can't.  On top of that, what you
were complaining about isn't the point.  The thing that you say 
BK can't do, but it can, is not what Linus wants.  Not even close.

And you haven't begun to understand that BK is a distributed, replicated
system.  You can turn all that off and you've got CVS, so turning it
off isn't an option.  Leaving it on means that the revision history is
replicated.  So it isn't an option to collapse a pile of changes into
a smaller pile, the bigger pile will come back the next time he updates
with the other tree.

And once again, you come back with another post that shows you just want
to yell and you haven't thought it through, into my kill file you go,
my blood pressure goes down, you get to yell all you want, everybody
is happy.  I'm willing to try and make BK do what is needed here; I'm
not willing to tolerate people who don't think.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
