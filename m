Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRCNTw1>; Wed, 14 Mar 2001 14:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131499AbRCNTwS>; Wed, 14 Mar 2001 14:52:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13456 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131528AbRCNTv6>;
	Wed, 14 Mar 2001 14:51:58 -0500
Date: Wed, 14 Mar 2001 14:51:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Dave Kleikamp <shaggy@austin.ibm.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <200103141945.f2EJjF410285@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103141448150.4468-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001, Andreas Dilger wrote:

> David Kleikamp writes:
> > AIX stores all of this information in the LVM, not in the filesystem. 
> > The filesystem itself has nothing to do with importing and exporting
> > volume groups.  Having the information stored as part of LVM's metadata
> > allows the utilities to only deal with LVM instead of every individual
> > file system.
> 
> So you are saying that mount(8) writes into a field in the LVM LVCB or
> something?  Might be possible on Linux LVM as well...

Makes sense. Even better than per-fs file in root on filesystems
affected by that policy. If the situation when you really want it is
LVM putting that (and probably fs type and other mount options) into
LVM metadata looks like a good idea.
							Cheers,
								Al

