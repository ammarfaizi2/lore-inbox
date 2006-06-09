Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWFIXLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWFIXLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWFIXLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:11:47 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:1156 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030279AbWFIXLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:11:46 -0400
Date: Fri, 9 Jun 2006 17:11:52 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Sonny Rao <sonny@burdell.org>, jeff@garzik.org, hch@infradead.org,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609231151.GL5964@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Sonny Rao <sonny@burdell.org>, jeff@garzik.org, hch@infradead.org,
	cmm@us.ibm.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <20060609214200.GA18213@kevlar.burdell.org> <20060609151553.30097b44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609151553.30097b44.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  15:15 -0700, Andrew Morton wrote:
> We seem to be lagging behind "the industry" in some areas - handling large
> devices, high bandwidth IO, sophisticated on-disk data structures, advanced
> manageability, etc.
> 
> I mean, although ZFS is a rampant layering violation and we can do a lot of
> the things in there (without doing it all in the fs!) I don't think we can
> do all of it.
> 
> We're continuing to nurse along a few basically-15-year-old filesystems
> while we do have the brains, manpower and processes to implement a new,
> really great one.
> 
> It's just this feeling I have ;)

I think many people share this feeling (me included), hence the linux
filesystem meeting next week...  The problem is that even getting a
half-decent disk filesystem is many years of work, and large disks are
here before then.  The ZFS code took 10 years to get to its current state,
I understand, so I don't anticipate we will get there overnight.

The question is whether we can get to this state more easily by starting
on a known-good base (ext3) or by starting from scratch.  My opinion is
strongly in the "start from a known-good base" camp, and make incremental
improvements to that base instead of discarding everything and starting
again.

I think the real frontier for future filesystem development is in the
ZFS direction where the filesystem can be robust in the face of data
errors without having a single fail-stop mode of error handling.  While
ext2 and ext3 have been OK in this regard they can definitely be improved
without discarding the rest of the code and the millions of hours of
testing that has gone into it.

I'm not so strongly against ext4 that I won't follow that route if needed,
but it essentially means that ext3 will be orphaned.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

