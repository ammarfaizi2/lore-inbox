Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbRCNTdR>; Wed, 14 Mar 2001 14:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRCNTdI>; Wed, 14 Mar 2001 14:33:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28912 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131506AbRCNTdC>;
	Wed, 14 Mar 2001 14:33:02 -0500
Date: Wed, 14 Mar 2001 14:32:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103141914.f2EJEVN10163@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103141428490.4468-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001, Andreas Dilger wrote:

> Obviously, the whole vgimport stuff is going to be in userland.  The only
> part that needs to go in the kernel is storing the mountpoint in the
> filesystem superblock.  It is _not_ OK to just put it in /.last.mounted.
> Quite often a data/application VG is moved independent of the root filesystem.
> The info needs to stay with the filesystem itself.

Sorry - .last.mounted in the root of filesystem, indeed.

> > Since the reading side contains a bunch of heuristics
> > (obviously depending on the local naming policy for temp. mountpoints,
> > for one thing) you don't need anything special on the writing side...
> 
> The writing side can't be done in userland without basically making
> mount(8) know about the superblock layout of each and every filesystem:

That's a wonderful reason to put it _not_ into superblock... OK, what's
wrong with the variant above?

							Cheers,
								Al

