Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287248AbRL2XaI>; Sat, 29 Dec 2001 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287246AbRL2X36>; Sat, 29 Dec 2001 18:29:58 -0500
Received: from waste.org ([209.173.204.2]:65495 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287243AbRL2X3y>;
	Sat, 29 Dec 2001 18:29:54 -0500
Date: Sat, 29 Dec 2001 17:29:52 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229150423.G19306@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0112291705550.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> On Sat, Dec 29, 2001 at 04:24:56PM -0600, Oliver Xymoron wrote:
> > > OK, so this glorious patchbot is going to make sure that a patch patches
> > > cleanly against a known version and compiles.  And that buys me exactly
> > > what?  Not a heck of a lot.  Especially since, as is obvious, if you send
> > > in stuff that doesn't compile consistently, your patches are likely to go
> > > to the back of the line or just get dropped.
> >
> > It never shows up in the maintainer's inbox, leaving them more time to
> > address the remainder. And fewer of the increasingly bitter complaints of
> > dropped patches.
>
> I think it's great that Oliver is volunteering to build this system,
> host it, provide the build infrastructure and hardware, that's cool!  But
> wouldn't it be a whole lot less work to tell people to type make before
> they send in the patch?

Which works until the next rev of the kernel at which point the patch may
not be valid any more.

> Is it really true that there are any significant number of patches
> submitted that don't even compile?

No, it was mostly just pointing out that it was possible to do with kbuild
and CML2 in O(patch) rather than O(whole kernel). Testing applicability of
the patch is 80% of the work.

> And while we are the build topic, what platforms get built?  What configs?

Up to whoever $maintainer happens to be. If DaveM runs a patch queue
the answer probably includes Sparc, otherwise it defaults to x86. The
config question was answered in my original proposal.

> > > I'm prepared to be wrong, but I don't hear the maintainers asking for this
> > > patchbot.  Why not?
> >
> > I don't hear them asking for SCM either.
>
> OK Socrates, nice try, but try and stay focussed and answer the question.
> It's right there above your non-answer.

Actually my answer is perfectly to the point: clearly you know exactly why
someone would keep harping on about a patch management solution no one
seems very interested in, so I hardly need to spell it out for you. But
I can add some details:

- Linus has limited bandwidth, and as is becoming clear, so do the
  other maintainers
- dropped patches are the primary indicator of this
- people don't implement exponential back-off well, they tend to get
  cranky instead
- feedback is a good way to reduce congestion and resends
- the old solution, Jitterbug, was horrid


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


