Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273147AbRIJCHs>; Sun, 9 Sep 2001 22:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273146AbRIJCHj>; Sun, 9 Sep 2001 22:07:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273139AbRIJCHd>; Sun, 9 Sep 2001 22:07:33 -0400
Date: Sun, 9 Sep 2001 19:03:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <1299510000.1000086297@tiny>
Message-ID: <Pine.LNX.4.33.0109091901130.23952-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Chris Mason wrote:
>
> On Monday, September 10, 2001 03:04:05 AM +0200 Andrea Arcangeli
> <andrea@suse.de> wrote:
> >
> > I also recommend to write it on top of the blkdev in pagecache patch
> > since there I just implemented the "physical address space" abstraction,
> > I had to write it to make the mknod hda and mknod hda.new to share the
> > same cache transparently.

Agreed - they do share a _lto_ of the issues.

> I some code on top of the writepage for all io patch (2.4.2 timeframe),
> that implemented getblk_mapping, get_hash_table_mapping and bread_mapping,
> which gave the same features as the original but took an address space as
> one of the args.
>
> Anyway, the whole thing can be cut down to a smallish patch, either alone
> or on top of andrea's stuff.  Daniel, if you want to work together on it,
> I'm game.

If you'd be willing to integrate your patches on top of andreas (and
massage them to be the _only_ getblk interface) and look what the
resulting thing looks like, I bet that there will be a lot of people
interested in working on any final remaining issues.

The devil is always in the details, but at the same time it ends up being
rather important to get some first "mostly-working" code to base further
refinements on, unless we want to just talk the problem to death ;)

		Linus

