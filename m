Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTBPFJl>; Sun, 16 Feb 2003 00:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbTBPFJl>; Sun, 16 Feb 2003 00:09:41 -0500
Received: from [209.195.52.121] ([209.195.52.121]:5022 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S265872AbTBPFJi>; Sun, 16 Feb 2003 00:09:38 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Date: Sat, 15 Feb 2003 21:18:42 -0800 (PST)
Subject: Re: openbkweb-0.0
In-Reply-To: <Pine.LNX.4.44.0302151836370.13273-100000@xanadu.home>
Message-ID: <Pine.LNX.4.44.0302152104500.6594-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, as I see it there are two different groups wanting access to this
stuff without useing bitkeeper.

1. people who want to get a copy of that the kernel looks like right NOW
for who the currently hourly diffs and mailing list of patch submissions
isn't good enough.

These people want CVS/rsync access to the files, cut could probably be
satisfied with FTP/HTTP access and appropriate mirroring software.

2. people who can't/won't use bitkeeper but who want not only the
resulting files, but also all the underlying change history info.

This info is stored in SCCS format so just getting a current copy of the
tree including the SCCS directories should be good enough to satisfy them
and they can then run all the normal SCCS tools to access the info.

can the SCCS stuff be exported through CVS or do these people need some
other mechanism to get them?

after my offer to admin a mirror of bkbits that provides access through
ohter mechanisms I have been contacted by some people willing to provide
the server/bandwidth to host such a system and we are discussing the
details of how this will be setup so now the question is what services do
people need from such a mirror?

On the basis that it's easier to provide everything rather then to
convince people to change tools :-) here is what I'm thinking of (all of
these obviously read-only)

CVS
rsync
FTP
HTTP

is there anything else people want?

all of these would provide access to the raw files in the tree(s), none of
these will provide tarballs (if you want those contact the people who are
already hosting such services and live with the timelag)

David Lang

 On Sat, 15 Feb 2003, Nicolas Pitre wrote:

> Date: Sat, 15 Feb 2003 23:08:58 -0500 (EST)
> From: Nicolas Pitre <nico@cam.org>
> To: Larry McVoy <lm@bitmover.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
> Subject: Re: openbkweb-0.0
>
> On Sat, 15 Feb 2003, Larry McVoy wrote:
>
> > On Sat, Feb 15, 2003 at 08:44:59PM +0000, Alan Cox wrote:
> > > On Sat, 2003-02-15 at 18:12, Larry McVoy wrote:
> > > > All of this sounds great and is exactly what is already the plan.
> > > > There is one missing item.  A consensus in the community that if we
> > > > provide BK, the CVS mirror, bkbits hosting, in return the community
> > > > agrees to leave off using BK to copy BK.
> > >
> > > The community is an amorphous thing so thats tricky to define
> >
> > You're right, I thought of that after I posted.  What would probably
> > work best is if someone who was not particularly BK friendly but
> > is acknowledged as a Linux leader were to step forward and agree to
> > represent the community interests.
>
> Larry, what you ask is impossible.
>
> This community isn't hierarchized and is unlikely to form a single opinion
> on anything like corporate politics.  No one can be authoritative of
> everybody else's opinion.
>
> It doesn't work in a pull model either where you ask for things.  Rather,
> you must push things and see how it goes, how people react.
>
> > It's clear from the fuss this causes about every three weeks that people
> > don't feel safe, on either side.  You're scared that we're going to do
> > some evil thing and we're scared that you are going to do evil thing.
>
> That might be true, but I think the BK opponents from the community are more
> concerned by preserving their "freedom" (or ability) to access the
> up-to-the-minute changes that appeared in the official kernel reference
> repository, and without being forced to use a proprietary tool with a
> proprietary protocol and with restrictive license terms.  I really think it
> has nothing to do with BK itself beside the fact that it's BK that is used
> to handle the data they cherish so much and no "free" path currently exists
> to that data.  Even if hourly snapshots do exist, that still makes those
> people sort of second class citizens.  They want the changes available to
> them in real time but in the most purist free way too.  The best answer is a
> CVS gateway IMHO, and then the true believers, or those who simply can't
> comply with your license for all sort of good and legitimate reasons, won't
> have anything against you from that moment since they won't see BK as an
> obstacle in the way.
>
> If a real time CVS gateway exists, and bkbits.net is pushing CVS commits to
> kernel.org and linux.org.uk just to name those few obvious examples among
> others, then individuals within this community will have the choice between
> many tools according to their respective characteristics and not based on the
> quality of service with regards to the kernel repository.
>
> Only then people won't be able to invoke the BitMover lock-in argument
> against the Linux community (regardless if that was your intention or not),
> and only then will you be able to consider those who try to reverse-engineer
> your "technology" as bad people, since invoking fair use will then be much
> harder to legitimate.
>
> In other words, if people can have real time change sets to the reference
> kernel and have the possibility of ignoring you and BK entirely at the same
> time, only then the issue will be closed.
>
> > Maybe it's not possible, but it would be nice if we could, operating in
> > good faith, work out some sort of agreement that made sense.  Yeah, I
> > know it isn't binding, that the best you could do on the community side is
> > have a bunch of people stand up and say "hey, leave BitMover alone, they
> > are doing a good service" but I'd take that over the current mess any day.
>
> You are doing the best you can in the terms you chose, and a lot of people
> including myself are extremely grateful.  Your terms are just totally
> incompatible with the view of some people.  And many of those people just
> don't like what you do and they _never_ will, that's a simple fact of life.
> Your only way out is to provide a mechanism that will allow them to totally
> ignore you without impairing their access to the kernel development data.
> BK might be way ahead at what it does, but real-time access to the kernel
> repository must _not_ be among the advantages of BK against competitor
> products/solutions.
>
>
> Nicolas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
