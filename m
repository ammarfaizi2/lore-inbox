Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbQLUSPm>; Thu, 21 Dec 2000 13:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131195AbQLUSPc>; Thu, 21 Dec 2000 13:15:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35684 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131158AbQLUSPR>; Thu, 21 Dec 2000 13:15:17 -0500
Date: Thu, 21 Dec 2000 18:44:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001221184424.C29083@athlon.random>
In-Reply-To: <20001221161952.B20843@athlon.random> <Pine.LNX.4.21.0012211502400.1613-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0012211502400.1613-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Dec 21, 2000 at 03:07:08PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 03:07:08PM -0200, Rik van Riel wrote:
> c) will also implement a) in an obviously right and simple way.

So go ahead. If you think that's so simple and obviously right you can post
here a patch here against 2.2.19pre2 that implements C) to show real facts.

My B is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre2/wake-one-2

Then we will see how much C) is obviously right and simple way compared to B).

I don't need to see C) implemented to see how much it's obviously right
and simple but if you think I'm wrong again: go ahead.

It would also be nice if you could show a real life
showstopper-production-bottleneck where we need C) to fix it. I cannot see any
useful usage of C in production 2.2.x.

Doing waitqueues in 2.2.x and 2.4.x is an irrelevant point (keeping the same
API and semantics is much better than anything else for 2.2.x unless there's
some serious showstopper that isn't possible to fix with B) and that I still
cannot see).

People backporting drivers from 2.4.x will use wake-all as they had to do
during the whole 2.3.x, that's obviously safe and trivial. If they know what
they're doing they can also use the 2.2.x wake-one API if their task is
registered only in 1 waitqueues (as 99% of usages I'm aware of given
whole 2.3.x implemented B too).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
