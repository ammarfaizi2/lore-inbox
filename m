Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTBEUPS>; Wed, 5 Feb 2003 15:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBEUPR>; Wed, 5 Feb 2003 15:15:17 -0500
Received: from [195.223.140.107] ([195.223.140.107]:25472 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264697AbTBEUPQ>;
	Wed, 5 Feb 2003 15:15:16 -0500
Date: Wed, 5 Feb 2003 21:24:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Matt Reppert <arashi@yomerashi.yi.org>
Cc: Andrew Morton <akpm@digeo.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205202436.GN19678@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 02:11:04PM -0600, Matt Reppert wrote:
> (CC'ing Linus because I have a question for him in here ... )
> On Wed, 5 Feb 2003 11:43:53 -0800
> Andrew Morton <akpm@digeo.com> wrote:
> >
> > http://linux.bkbits.net:8080/linux-2.5/cset@1.879.43.1?nav=index.html|ChangeSet@-8w
> > 
> > And revtool shows that change on Jan 09 this year.
> > 
> > But it does not appear in Linus's 2.5.59 tarball, and there appears to be no
> > record in bitkeeper of where this change fell out of the tree.
> > 
> > In fact the above URL shows two instances of the same patch, with different
> > human-written summaries, on the same day.
> > 
> > I believe that shaggy had some problem with the nobh stuff, so possibly the
> > January 9 change was reverted in some manner, and it was reapplied
> > post-2.5.59, and the web interface does now show the revert.  Revtool does
> > not show it either.  Nor the reapply.
> > 
> > It is quite confusing.  Yes, something might have gone wrong.
> 
> I sit on the web interface a lot to see what's being merged. If you ask for
> it, it will give you a list of csets ordered by date, newest first. I've
> noticed sometimes that recently merged csets will appear to be older than
> the date they were merged, perhaps because they actually were that old in

if the date is old it's not a problem, I mean, it's ok if they're not
ordered by date of creation of the code. But it would make lots of sense
if the "past" could remain intact.

The problem is if a new changesets can appear in the past, rather than
being always added at the head (no matter the date). If they appear in
the past they can modify every single changeset diff from that point in
the past to the head.

Andrea
