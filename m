Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAISwV>; Tue, 9 Jan 2001 13:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAISwM>; Tue, 9 Jan 2001 13:52:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33808 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129632AbRAISwE>; Tue, 9 Jan 2001 13:52:04 -0500
Date: Tue, 9 Jan 2001 10:51:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Richard Henderson <rth@twiddle.net>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        richbaum@acm.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <200101091002.f09A2gw281603@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.10.10101091048590.2070-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Albert D. Cahalan wrote:

> [about labels w/o statements after them]
> 
> >> Is this really a kernel bug? This is common idiom in C, so gcc
> >> shouldn't warn about it. If it does, it is a bug in gcc IMHO.
> >
> > No, it is not a common idiom in C.  It has _never_ been valid C.
> >
> > GCC originally allowed it due to a mistake in the grammar; we
> > now warn for it.  Fix your source.
> 
> Since neither -ansi nor -std=foo was specified, gcc should just
> shut up and be happy. Consider this as another GNU extension.

No, it was a gcc bug that gcc accepted the syntax in the first place.

Let the gcc people fix the bugs they find without complaining about them.
After all, gcc would have been perfectly correct in signalling this as a
syntax error, and aborted compilation. The fact that gcc only warns about
it is a sign of grace - it's not as if it is a _useful_ extension that
gives the programmer anything new and should be left in for that reason.

We'll fix up the kernel. That's where the bug is.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
