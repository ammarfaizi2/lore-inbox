Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSHBMNe>; Fri, 2 Aug 2002 08:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSHBMNe>; Fri, 2 Aug 2002 08:13:34 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:30776 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S310190AbSHBMNd>;
	Fri, 2 Aug 2002 08:13:33 -0400
Subject: Re: BIG files & file systems
From: Chris Mason <mason@suse.com>
To: Stephen Lord <lord@sgi.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Alexander Viro <viro@math.psu.edu>,
       "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1028246981.11223.56.camel@snafu>
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu> 
	<20020801035119.GA21769@ravel.coda.cs.cmu.edu> 
	<1028246981.11223.56.camel@snafu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Aug 2002 08:17:59 -0400
Message-Id: <1028290680.12670.199.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 20:09, Stephen Lord wrote:

> > > You _do_ need unique ->st_ino from stat(2), though - otherwise tar(1)
> > > and friends will break in all sorts of amusing ways.  And there's
> > > nothing kernel can do about that - applications expect 32bit st_ino
> > > (compare them as 32bit values, etc.)
> > 
> > Which is why "tar and friends" are to different extents already broken
> > on various filesystems like Coda, NFS, NTFS, ReiserFS, and probably XFS.
> > (i.e. anything that currently uses iget5_locked instead of iget to grab
> > the inode).
> 
> Why are they broken? In the case of XFS at least you still get a unique
> and stable inode number back - and it fits in 32 bits too.

reiserfs is not broken here.  It has unique stable 32 bit inode numbers,
but looking up the file on disk requires 64 bits of information.

-chris


