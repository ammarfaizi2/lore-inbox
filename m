Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319584AbSIHJTE>; Sun, 8 Sep 2002 05:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319585AbSIHJTE>; Sun, 8 Sep 2002 05:19:04 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:9233 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319584AbSIHJTD>;
	Sun, 8 Sep 2002 05:19:03 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209080923.g889Ndp03091@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <20020907211452.GA24476@marowsky-bree.de> from Lars Marowsky-Bree
 at "Sep 7, 2002 11:14:53 pm"
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Sun, 8 Sep 2002 11:23:39 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Lars Marowsky-Bree wrote:"
> > > In particular, they make them useless for the requirements you seem to
> > > have. A petabyte filesystem without journaling? A petabyte filesystem with
> > > a single write lock? Gimme a break.
> > Journalling? Well, now you mention it, that would seem to be nice.
> 
> "Nice" ? ;-) You gotta be kidding. If you don't have journaling, distributed
> recovery becomes near impossible - at least I don't have a good idea on how to

It's OK. The calculations are duplicated and the FS's are too. The
calculation is highly parallel.

> do it if you don't know what the node had been working on prior to its
> failure.

Yes we do. Its place in the topology of the network dictates what it was
working on, and anyway that's just a standard parallelism "barrier"
problem.

> Well, you are taking quite a risk trying to run a
> not-aimed-at-distributed-environments fs and trying to make it distributed by
> force. I _believe_ that you are missing where the real trouble lurks.

There is no risk, because, as you say, we can always use nfs or another
off the shelf solution. But 10% better is 10% more experiment for
each timeslot for each group of investigators.

> What does this supposed "flexibility" buy you? Is there any real value in it

Ask the people ho might scream for 10% more experiment in their 2
weeks.

> > You mean "what's wrong with X"? Well, it won't be mainstream, for a start,
> > and that's surely enough.
> 
> I have pulled these two sentences out because I don't get them. What "X" are
> you referring to?

Any X that is not a standard FS. Yes, I agree, not exact.

> The insight I can offer you is look at OpenGFS, see and understand what it
> does, why and how. The try to come up with a generic approach on how to put
> this on top of a generic filesystem, without making it useless.
> 
> Then I shall be amazed.

I have to catch a plane ..

Peter
