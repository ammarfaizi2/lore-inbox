Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271875AbRIIEPr>; Sun, 9 Sep 2001 00:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271876AbRIIEPi>; Sun, 9 Sep 2001 00:15:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25860 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271875AbRIIEP2>; Sun, 9 Sep 2001 00:15:28 -0400
Date: Sun, 9 Sep 2001 06:16:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
Message-ID: <20010909061620.O11329@athlon.random>
In-Reply-To: <20010909053015.L11329@athlon.random> <Pine.LNX.4.33.0109082051040.1161-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109082051040.1161-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Sep 08, 2001 at 08:58:26PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 08:58:26PM -0700, Linus Torvalds wrote:
> I'd rather fix that, then.

we'd just need to define a new kind of communication API between a ro
mounted fs and the blkdev layer to avoid the special cases. I
intentionally didn't changed the API and I didn't broken the rules so I
could use the code in 2.4 with all the filesystems transparently (also
the ones not in mainline of course).

> Otherwise we'll just end up carrying broken baggage around forever. Which
> is not the way to do things.

it's not broken, nor even very complex, it may be even cleaner but such
a cleanup that would involve all the filesystems out there wasn't
actually in my high prio list (and certainly not something I would like
to do in 2.4 too).

It's like having numbers to name devices when everybody (apps included)
only knows the names, not the numbers, the API totally sucks obviously,
but that doesn't affect at all the core code that you benchmark etc..,
it doesn't affect when you read or write to the device etc... and this
is why nobody was forced to clean it up yet because the pain was more
than the gain (in such case the pain was even bigger of course, because
the change will be visible to userspace and not only breaking all the
fses).

Andrea
