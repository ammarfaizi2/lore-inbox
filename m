Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131292AbRCNFMR>; Wed, 14 Mar 2001 00:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131304AbRCNFMI>; Wed, 14 Mar 2001 00:12:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3212 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131292AbRCNFLw>;
	Wed, 14 Mar 2001 00:11:52 -0500
Date: Wed, 14 Mar 2001 00:11:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103140427.f2E4R9C06455@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103140010050.2506-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Mar 2001, Andreas Dilger wrote:

> You write:
> > > What about if I want to know the mountpoint (inside the filesystem)
> > > when it is mounted?
> > 
> > Which mountpoint? There can be a lot of them (quite possibly - some
> > of them out of the chroot jail you are in, so "any" is unlikely to
> > do you any good).
> 
> How about the first one?  The one that calls the "read_super" method.
> AFAICT, only the first mount calls down to the FS anyways (the rest
> is VFS internal).

And what should that be after

mount -t ext2 /dev/sda1 /mnt
mount --bind /mnt /tmp/foo
umount /mnt


