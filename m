Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTBFRVQ>; Thu, 6 Feb 2003 12:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTBFRVQ>; Thu, 6 Feb 2003 12:21:16 -0500
Received: from bitmover.com ([192.132.92.2]:45786 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264956AbTBFRVP>;
	Thu, 6 Feb 2003 12:21:15 -0500
Date: Thu, 6 Feb 2003 09:30:50 -0800
From: Larry McVoy <lm@bitmover.com>
To: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030206173050.GA15854@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org> <20030205233115.GB14131@work.bitmover.com> <20030205233705.A31812@infradead.org> <20030205235706.GB21064@work.bitmover.com> <20030206095850.D18636@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206095850.D18636@schatzie.adilger.int>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And is everyone happy with 8.0's glibc, if we offer that up until 8.1 comes
> > out?  If so, we'll buy a machine and add it to the build cluster this week.
> 
> UML is your friend here - you can have a whole set of distros/revisions all
> on the same host.

We do our builds in parallel on all platforms (except s390, that one
is special for obvious reasons).  Even with a fast machine it takes a
while to do the build/test cycle.  So we allocate a machine/platform.

The cost of the machine doesn't bother me that much, actually, it's
the power.  The power bill for our build cluster is about $800/month.
I've thought of putting all the machines on a software controlled
power switch and turning them on when we need it but bring up on some
of these is manual (headless machines that don't want to be headless,
the alpha machine refuses to autoboot, etc) and my experience is that
power cycling is a great way to make machines die young.

So we're sort of stuck with the current model.  It's not that bad, we 
use cheap machines, it will cost me maybe $400 to put a new machine 
up, that's hardly something to get excited about if it makes some
problems go away.

What I'd really like to know is if we really need a glibc2.3 image. 
Would the guy who had the segfaults step foward and confirm/deny the
use of the static image?  We haven't had any other problem reports
related to glibc2.3 so it may be there is no need to do anything but
kill the static version.  I can always hand roll one for Gooch.  Does
anyone else need a.out support?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
