Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSEYR1L>; Sat, 25 May 2002 13:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSEYR1K>; Sat, 25 May 2002 13:27:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23052 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313125AbSEYR1J>; Sat, 25 May 2002 13:27:09 -0400
Date: Sat, 25 May 2002 10:27:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Schwebel <robert@schwebel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020525110830.U598@schwebel.de>
Message-ID: <Pine.LNX.4.44.0205251025010.6515-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Robert Schwebel wrote:
> >
> > Which is, in my opinion, the only sane way to handle hard realtime. No
> > confusion about priority inversions, no crap. Clear borders between what
> > is "has to happen _now_" and "this can do with the regular soft realtime".
>
> ... which in turn results in the situation that applications must be
> implemented as kernel modules.

That's a load of bull.

It results in the fact that you need to have a _clear_interface_ between
the hard realtime parts, and the stuff that isn't.

Yes, that does imply a certain amount of good design. And it requires you
to understand which parts are time-critical, and which aren't.

> This is only correct for open-loop applications. Most real life apps are
> closed-loop.

Most real life apps have nothing to do with hard-RT.

		Linus

