Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286584AbRL0UKz>; Thu, 27 Dec 2001 15:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286585AbRL0UKp>; Thu, 27 Dec 2001 15:10:45 -0500
Received: from bitmover.com ([192.132.92.2]:11934 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286584AbRL0UKf>;
	Thu, 27 Dec 2001 15:10:35 -0500
Date: Thu, 27 Dec 2001 12:10:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227121033.F25698@work.bitmover.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011227165752.A19618@flint.arm.linux.org.uk> <Pine.LNX.4.33L.0112271509570.12225-100000@duckman.distro.conectiva> <a0fntk$ukm$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <a0fntk$ukm$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 27, 2001 at 06:05:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 06:05:40PM +0000, Linus Torvalds wrote:
> Note that things like CVS do not help the fundamental problem at all. 
> They allow automatic acceptance of patches, and positively _encourage_
> people to "dump" their patches on other people, and not act as real
> maintainers. 

Huh.  I'm not sure I understand this.  Once you accept a patch into the
mainline source, are these people still supposed to maintain that patch?
I would think the patch is now sort of dead, and any subsequent changes
are a new patch, right?  If so, what I'm missing is how a source
management system makes a difference in this case, it seems sort of 
orthogonal.

> We've seen this several times in Linux - David, for example, used to
> maintain his CVS tree, and he ended up being rather frustrated about
> having to then maintain it all and clean up the bad parts because I
> didn't want to apply them (and he didn't really want me to) and he
> couldn't make people clean up themselves because "once it was in, it was
> in". 

Isn't this a limitation of CVS?  I really don't want to get into a
"BitKeeper is better" discussion, but the PPC guys use BK and manage to
extract the right parts of the tree to send you as patches.  In fact, BK
can extract any logical change as a patch with "bk export -tpatch <rev>".
If Dave had been using BK would that have helped or not?

> I know that source control advocates say that using source control makes
> it easy to revert bad stuff, but that's simply not TRUE.  It's _not_
> easy to revert bad stuff.  

It's trivial to revert bad stuff if other stuff hasn't come to depend
on that bad stuff, assuming a reasonable SCM system.  There are really
two issues here: one is the bookkeeping necessary to be able to say
"make this patch go away", and BK does that with a "bk cset -x<rev>",
but the second is much harder.  The second is "how do I undo this patch
now that other stuff has built on it?".  Where "built on it" means that
if I were to reverse patch the files, the reverse patch will have rejects.

If you can deal with #2, BK can deal with #1.  And I can give you help
with #2 in the form of showing you what changed and why.  It's basically
the same problem as merging and we do that well.

> The only way to handle bad stuff is to make
> people _responsible_ for their own sh*t, and have them maintain it
> themselves. 

Isn't this just a "reject" button on the patch?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
