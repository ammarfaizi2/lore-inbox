Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286620AbRL0UXf>; Thu, 27 Dec 2001 15:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286603AbRL0UX0>; Thu, 27 Dec 2001 15:23:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12043 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286616AbRL0UXR>; Thu, 27 Dec 2001 15:23:17 -0500
Date: Thu, 27 Dec 2001 12:21:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011227121033.F25698@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0112271213210.1167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Larry McVoy wrote:
> On Thu, Dec 27, 2001 at 06:05:40PM +0000, Linus Torvalds wrote:
> > Note that things like CVS do not help the fundamental problem at all.
> > They allow automatic acceptance of patches, and positively _encourage_
> > people to "dump" their patches on other people, and not act as real
> > maintainers.
>
> Huh.  I'm not sure I understand this.  Once you accept a patch into the
> mainline source, are these people still supposed to maintain that patch?

Yes, I actually do expect them to.

It obviously depends on the kind of patch: if it is a one-liner bug-fix,
the patch is pretty much dead (that is, of course, assuming it was a
_correct_ bug-fix and didn't expose any other latent bugs).

But for most things, it's a kind of "Tag, you're it" thing. You're
supposed to support the patch (ie step up and explain what it does if
anybody wonders), and help it evolve. Many patches are only stepping
stones.

(This, btw, is something that Al Viro does absolutely beautifully. I don't
know how many people look at Al's progression of patches, but they are
stand-alone patches on their own, while at the same time _also_ being part
of a larger migration to the inscrutable goals of Al - ie namespaces etc.
You may not realize just _how_ impressive that is, and what a absolute
wonder it is to work with the guy. Poetry in patches, indeed).

> > I know that source control advocates say that using source control makes
> > it easy to revert bad stuff, but that's simply not TRUE.  It's _not_
> > easy to revert bad stuff.
>
> It's trivial to revert bad stuff if other stuff hasn't come to depend
> on that bad stuff, assuming a reasonable SCM system.

Well, there's the other part to it - most bad stuff is just "random crap",
and may not have any physical bad tendencies except to make the code
uglier. Then, people don't even realize that they are doing things the
wrong way, because they do cut-and-paste, or they just can't do things the
sane way because the badness assumes a certain layout.

And THAT is where badness is actively hurtful, while not being buggy.
Which is why I'd much rather have people work on maintenance, and not rely
on the bogus argument of "we can always undo it".

		Linus

