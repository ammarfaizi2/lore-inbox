Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTBSRk0>; Wed, 19 Feb 2003 12:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTBSRkZ>; Wed, 19 Feb 2003 12:40:25 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:43137 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261530AbTBSRkX>;
	Wed, 19 Feb 2003 12:40:23 -0500
Date: Wed, 19 Feb 2003 18:49:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrew Morton <akpm@digeo.com>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: filesystem access slowing system to a crawl
Message-ID: <20030219174940.GJ14633@x30.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <20030205013909.6a8c04a3.akpm@digeo.com> <200302191742.02275.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302191742.02275.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 05:42:34PM +0100, Marc-Christian Petersen wrote:
> On Wednesday 05 February 2003 10:39, Andrew Morton wrote:
> 
> Hi Andrew,
> 
> > > Running just "find /" (or ls -R or tar on a large directory) locally
> > > slows the box down to absolute unresponsiveness - it takes minutes
> > > to just run ps and kill the find process. During that time, kupdated
> > > and kswapd gobble up all available CPU time.
> > Could be that your "low memory" is filled up with inodes.  This would
> > only happen in these tests if you're using ext2, and there are a *lot*
> > of directories.
> > I've prepared a lineup of Andrea's VM patches at
> > It would be useful if you could apply 10_inode-highmem-2.patch and
> > report back.  It applies to 2.4.19 as well, and should work OK there.
> is there any reason why this (inode-highmem-2) has never been submitted for 
> inclusion into mainline yet?

Marcelo please include this:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre4aa3/10_inode-highmem-2

other fixes should be included too but they don't apply cleanly yet
unfortunately, I (or somebody else) should rediff them against mainline.

Andrea
