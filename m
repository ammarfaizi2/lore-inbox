Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310740AbSC1AKe>; Wed, 27 Mar 2002 19:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310749AbSC1AKO>; Wed, 27 Mar 2002 19:10:14 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:34063 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S310740AbSC1AKI>; Wed, 27 Mar 2002 19:10:08 -0500
Date: Thu, 28 Mar 2002 00:09:38 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <20020327180247.GU21133@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0203280005160.17217-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Andreas Dilger wrote:

> If the I/O is normally sync driven, you should consider testing ext3
> with "data=journal".  While this seems counterintuitive because it is
> writing the data to disk twice, it can often be faster in real-world
> "bursty" environments because the sync I/O goes to the journal in one
> contiguous write, and it can then be written to the rest of the fs
> asynchronously safely.

Good point (and partially borne out by my new numbers).

> You can also set up an external journal device so that the journal is
> on another disk and avoid seeking between the journal and the rest of
> the filesystem.

Good idea.  If I had only a disks - a slow one and a fast one,
how should they be configured?  (Or might this be another area
worthy of testing?  The tradeoffs can go both ways -- the slow
disk might seem better for the async writes, but it'll also be
worse at seeking, so perhaps might be more appropriate for the
journal disk?)

Matthew.

