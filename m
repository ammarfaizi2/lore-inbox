Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131565AbRAITz2>; Tue, 9 Jan 2001 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131517AbRAITzS>; Tue, 9 Jan 2001 14:55:18 -0500
Received: from 041imtd176.chartermi.net ([24.247.41.176]:8595 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S130231AbRAITzN>; Tue, 9 Jan 2001 14:55:13 -0500
Date: Tue, 9 Jan 2001 14:53:52 -0500
From: Simon Kirby <sim@stormix.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010109145352.A23691@stormix.com>
In-Reply-To: <dnbstgewoj.fsf@magla.iskon.hr> <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 09, 2001 at 10:47:57AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 10:47:57AM -0800, Linus Torvalds wrote:

> And this _is_ a downside, there's no question about it. There's the worry
> about the potential loss of locality, but there's also the fact that you
> effectively need a bigger swap partition with 2.4.x - never mind that
> large portions of the allocations may never be used. You still need the
> disk space for good VM behaviour.
> 
> There are always trade-offs, I think the 2.4.x tradeoff is a good one.

Hmm, perhaps you could clarify...

For boxes that rarely ever use swap with 2.2, will they now need more
swap space on 2.4 to perform well, or just boxes which don't have enough
RAM to handle everything nicely?

I've always been tending to make swap partitions smaller lately, as it
helps in the case where we have to wait for a runaway process to eat up
all of the swap space before it gets killed.  Making the swap size
smaller speeds up the time it takes for this to happen, albeit something
which isn't supposed to happen anyway.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
