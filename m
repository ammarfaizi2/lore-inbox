Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282491AbRLLWGZ>; Wed, 12 Dec 2001 17:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282392AbRLLWGK>; Wed, 12 Dec 2001 17:06:10 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:45060 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S282453AbRLLWFy>; Wed, 12 Dec 2001 17:05:54 -0500
Date: Wed, 12 Dec 2001 16:05:51 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011212160551.A24992@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <20011211014346.C4801@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011211014346.C4801@athlon.random>; from andrea@suse.de on Tue, Dec 11, 2001 at 01:43:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 01:43:46AM +0100, Andrea Arcangeli wrote:
| On Mon, Dec 10, 2001 at 05:08:44PM -0200, Marcelo Tosatti wrote:
| > Andrea, 
| > Could you please start looking at any 2.4 VM issues which show up ?
| 
| well, as far I can tell no VM bug should be present in my latest -aa, so
| I think I'm finished. At the very least I know people is using 2.4.15aa1
| and 2.4.17pre1aa1 in production on multigigabyte boxes under heavy VM
| load and I didn't got any bugreport back yet.
[...]

I look forward to this stuff.  2.4 mainline falls down reliably and
completely when running updatedb on systems with a large number of used
inodes.  Linus' VM/mmap patch helped a ton, but between general VM
issues and the i/dcache bloat I'm hoping that I won't have to redirect
my irritated users' ire into a karma pool to get these changes merged
into mainline where all of the knowledgeable folks here can beat out the
details.

I do think that the vast majority of users don't see this issue on
small-ish UP desktops.  But I'm about to buy >100 SMP systems for
production expansion which will most likely be effected by this issue.
For me that emphasizes that these so-called corner cases really are
show-stoppers for Linux-as-more-than-toy.

Gimme the /proc interface (bdflush?) and lets bang on this stuff in
mainline.  I need to stick with the latest -pre so I can track progress,
so 2.4.17pre4aa1 (or 10_vm-19) hasn't been a possibility for me... :-(

Cheers, just venting,
-- 
Ken.
brownfld@irridia.com

PS: Nice catch on the NTFS vmalloc() issue.

| > Just please make sure that when sending a fix for something, send me _one_
| > problem and a patch which fixes _that_ problem.
| 
| I will split something for you soon, at the moment I was doing some
| further benchmark.
| 
| > 
| > I'm tempted to look at VM, but I think I'll spend my limited time in a
| > better way if I review's others people work instead.
| 
| until I split something out, you can see all the vm related changes in
| the 10_vm-* patches in my ftp area.
| 
| Andrea
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
