Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131117AbRAQBO6>; Tue, 16 Jan 2001 20:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbRAQBOt>; Tue, 16 Jan 2001 20:14:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56580 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130032AbRAQBOl>; Tue, 16 Jan 2001 20:14:41 -0500
Date: Tue, 16 Jan 2001 17:14:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Does reiserfs really meet the "Linux-2.4.x patch submission
 policy"?
In-Reply-To: <20010116170539.A3497@vitelus.com>
Message-ID: <Pine.LNX.4.10.10101161706320.2641-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jan 2001, Aaron Lehmann wrote:
> On Tue, Jan 16, 2001 at 08:55:58PM +0100, Andr? Dahlqvist wrote:
> > I was very surprised when I checked my local kernel.org mirror this
> > morning, and noticed that the latest 2.4.1 pre-patch had grown to
> > ~180 kb in size. I was even more surprised when I realized that the
> > inclusion of reiserfs was the reason for this.
> 
> On a related note, how about XFS? It certainly shouldn't go in before
> the developers are ready, but I've been using it without any problems
> for awhile now and await its inclusion in the mainstream kernel.

Note that ResierFS really is a fairly special case: it's been one of the
main filesystems at SuSE for a longish time, and of the journalling
filesystems it's the only one I know of that is in major real production
use already, and has been for some time.

There's no question that there are other Journalling filesystems on the
horizon, but I'm not hearing anybody who can't do the patching themselves
who is interested in using it. Remember: one of the main criteria for
2.4.x inclusion was the "vendor would want it" part. If it's a "developers
might want to play with it" kind of thing, then it might as well live as
an external patch for a while.

For that reason, I would expect Ext3 to be the next filesystem to be
integrated, but I would _also_ expect that RedHat will actually integrate
it into their kernel _first_, and expect me to integrate it into the
standard kernel only afterwards.

But no, vendors aren't everything. And there are other vendors than just
SuSE and RedHat. So take all of the above with a pinch of salt. And
remember: these are just the 2.4.x rules - it's a different game when the
development kernel opens again, and "vendor wishes" are much less of an
issue when that happens. In the meantime, I see the stable kernel mainly
as a way to support vendors, and am thus always weighing things from that
angle when worrying about 2.4.x features.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
