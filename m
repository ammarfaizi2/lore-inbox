Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSFMEJs>; Thu, 13 Jun 2002 00:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317445AbSFMEJr>; Thu, 13 Jun 2002 00:09:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38563 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317444AbSFMEJr>;
	Thu, 13 Jun 2002 00:09:47 -0400
Date: Thu, 13 Jun 2002 00:09:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Francois Gouget <fgouget@free.fr>
cc: Stevie O <stevie@qrpff.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <Pine.LNX.4.43.0206122004420.18826-100000@amboise.dolphin>
Message-ID: <Pine.GSO.4.21.0206130008390.18281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Francois Gouget wrote:

> On Wed, 12 Jun 2002, Stevie O wrote:
> [...]
> > With it came a brand new type of symlink.  Instead of relying on some
> > special bitflag in the inode (as it appears on disk, anyway) to mark
> > these symlinks as such, they are instead regular files that are marked
> > as symlinks by the last four characters in the filename being ".lnk".
> >
> > This new method of storing symlinks is extremely useful -- it allows
> > one to create symlinks on a number of filesystems that you couldn't
> > before, because those filesystems have nowhere to store a 'S_IFLNK'
> > flag.
> [...]
> > Now comes my argument for putting it into the VFS.
> 
> Yes, this would be much more useful. Mainly because it would make it
> usable on more filesystems: VFAT, NTFS, ISO9660, etc.

Vetoed.  Consider what happens if you rename such file, for one thing.

