Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTBEUIj>; Wed, 5 Feb 2003 15:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBEUIi>; Wed, 5 Feb 2003 15:08:38 -0500
Received: from [195.223.140.107] ([195.223.140.107]:24192 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264822AbTBEUIh>;
	Wed, 5 Feb 2003 15:08:37 -0500
Date: Wed, 5 Feb 2003 21:18:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205201810.GM19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205195151.GJ19678@dualathlon.random> <20030205120903.1e84c12e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205120903.1e84c12e.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 12:09:03PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > it might be simply an error in the tarball, maybe Linus's tree isn't in
> > full sync with bk head. But something definitely is corrupt between
> > tarball and bk.
> 
> Well, the 2.5.59 BK tree shows that function using block_truncate_page() as
> well.
> 
> The question is why did the Jan 9 changeset in the 2.5.55 timeframe not
> appear in the tree until post-2.5.59.  Maybe on Jan 9 Linus only part-merged
> it by some means (making the web interface claim it is there), and this week
> completed the merge and updated the checkin comment?

I don't know how it is supposed to work, but this sounds quite messy, if
this is the case, how can you order the changesets?

I mean if that's "normal", then the changeset diffs that are on the ftp
site aren't something "constant" they can change over time when non
controversial stuff changes under them, and in turn it's pointless to
store them on kernel.org since they may be just changed in the bitkeeper
database by the time you go read them...

The way it should work to be cleaner, is that if Linus merged a
modification, no matter how, this modification gets *always* a new
changeset number at the head. Merging modifications in the past
invalidates every single changeset on kernel.org and in the mailing list
from that point in the past to the bk-head.

Andrea
