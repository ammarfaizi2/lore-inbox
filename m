Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSLPQ2p>; Mon, 16 Dec 2002 11:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSLPQ2p>; Mon, 16 Dec 2002 11:28:45 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:57604 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263362AbSLPQ2o>; Mon, 16 Dec 2002 11:28:44 -0500
Date: Mon, 16 Dec 2002 16:36:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.52
Message-ID: <20021216163631.A5342@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212151930120.12906-100000@penguin.transmeta.com> <20021216102639.A27589@infradead.org> <20021216151639.GQ504@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216151639.GQ504@hopper.phunnypharm.org>; from bcollins@debian.org on Mon, Dec 16, 2002 at 10:16:39AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 10:16:39AM -0500, Ben Collins wrote:
> > This merge looks fishy.  It seems to be yet another let's throw my CVS
> > repo in merge and backs out Al's work yo get rid of lots of devfs crap.
> 
> Quit talking shit. I go through a lot of effort to merge in changes sent
> to Linus' tree into the Linux1394 repo. I don't just dump changes for no
> good reason.
> 
> How about pointing out some specifics?

Take a look at the changeset at
http://linus.bkbits.net:8080/linux-2.5/diffs/drivers/ieee1394/dv1394.c@1.15?nav=index.html|src/|src/drivers|src/drivers/ieee1394|hist/drivers/ieee1394/dv1394.c.

Your big BLOB merge basically undoes everything in there.

> Maybe make my job easier by getting me some patches directly.

It was Al's patch, not mine.

> Trying to track two seperate source tree's isn't as easy as you might think.

In fact it's not difficult at all with a proper SCM, a bit of care and the
right attitude.  I merge the changes from XFS (and about half a donzend
XFS-related repositories inside SGI that all need proper merging / keeping
in sync) to Linus all the time.  And by keeping the changesets (or atomic
commits in SVN terminlogoy) as one patch each, hand-editing as needed when
merge conflicts arrive that works very well, even if I had been away and
the changes for four weeks need merging or as now we're five patchlevels
away from Linus tree (at 2.5.47).  I've not lost a single upstream change
with that merge policy yet.

And no, that's no BK advertisment, SGI uses a RCS-based SCM internally and
I use unfied diffs to get it into a staging repository for Linus to pull.
