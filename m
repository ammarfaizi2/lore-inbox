Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbTCLImI>; Wed, 12 Mar 2003 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263097AbTCLImI>; Wed, 12 Mar 2003 03:42:08 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:17198 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S263096AbTCLImE>; Wed, 12 Mar 2003 03:42:04 -0500
Date: Wed, 12 Mar 2003 09:45:35 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Richard Henderson <rth@twiddle.net>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <20030312001739.B30855@twiddle.net>
Message-ID: <Pine.LNX.4.30.0303120916430.17121-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Richard Henderson wrote:
> On Wed, Mar 12, 2003 at 09:02:08AM +0100, Szakacsits Szabolcs wrote:
> > gcc team must have, haven't it? Do you know?
>
> I have one test case.  It was never turned into anything
> that you could run.

The simplest test case I've found is at

	http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=57760

I did/do not have time to check it closely now but at first sight it's
the same I've found.

> > I thought about it, I'm just afraid too much kernel wouldn't build.
>
> Then it won't build.  Use a different compiler.

If we know the impact [how wildly broken compilers are used] we could
decide about the approach, IMHO.

Please note, this is not only about how to make build fail but how not
to waste potentially significant users and developers time if one
circumvent the blocking phase and starts distributing [intentional or
not] the broken binaries. Bigger the impact the bigger the chance it
happens.

> > This bug is in most 2.95, 2.96 and according to Alan in 3.0 and early
> > 3.1) and people would just start "working around" it by commenting out
> > the check for getting something to work quickly then forgetting about
> > the issue completely.
>
> The bug report I can find,
>
>    http://gcc.gnu.org/ml/gcc-patches/2001-06/msg00746.html
>
> was fixed before gcc 3.0.0 was released.  So if this is
> a different bug...

Could be also the classical "copy-paste [slightly change one occasion]
then fix one occasion" type of bug? I've never looked the quality of
the gcc source. I really don't know.

	Szaka

