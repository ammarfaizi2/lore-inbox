Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316963AbSEWRWe>; Thu, 23 May 2002 13:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSEWRWd>; Thu, 23 May 2002 13:22:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28164 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316963AbSEWRWd>; Thu, 23 May 2002 13:22:33 -0400
Date: Thu, 23 May 2002 10:09:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Dave McCracken <dmccr@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] POSIX personality
In-Reply-To: <Pine.LNX.3.96.1020523094611.11249A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0205231004470.1006-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 May 2002, Bill Davidsen wrote:
>
> I think the reason which comes to mind is avoiding future problems. By
> having a single POSIX mode flag not only does the program not have to know
> about setting the "right" other bits today, but if we find that POSIX
> behaviour is needed in some other area in the future, the program doesn't
> need to be modified and recompiled, because the POSIX behaviour "is in
> there" for all things.

That's a nice argument in theory, but if you change the behaviour of
existing flags, you might fix some program for the real semantics, but you
might equally well _break_ some program that unwittingly depended on the
old semantics.

So I think your argument is fundamentally flawed. The binary has been
tested with the old behaviour, and assuming that you can "fix" existing
binaries by changing kernel behaviour is a seriously flawed argument.

Yes, it might work for some programs, but basically you're on very thin
ice.

Does Linux break stuff when absolutely required? Sure. But designing an
interface that _plans_ on changing semantics is just incredibly stupid,
and should absolutely not be done. Ever.

			Linus

