Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbREXLZO>; Thu, 24 May 2001 07:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbREXLZE>; Thu, 24 May 2001 07:25:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3272 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261504AbREXLY6>;
	Thu, 24 May 2001 07:24:58 -0400
Date: Thu, 24 May 2001 07:24:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Maciek Nowacki <maciek@Voyager.powersurfr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <Pine.LNX.4.33.0105241250000.635-100000@mikeg.weiden.de>
Message-ID: <Pine.GSO.4.21.0105240724000.21818-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 May 2001, Mike Galbraith wrote:

> On Thu, 24 May 2001, Alexander Viro wrote:
> 
> > On Thu, 24 May 2001, Mike Galbraith wrote:
> >
> > > On Wed, 23 May 2001, Alexander Viro wrote:
> > >
> > > > Folks, who the hell is responsible for rd_inodes[] idiocy?
> > >
> > > That would have been me.  It was simple and needed at the time..
> > > feel free to rip it up :)
> >
> > Mike, I see what you are using it for, but you do realize that it
> > means that creating /tmp/ram0 and opening it once will make /tmp
> > impossible to unmount?
> 
> I don't _think_ that was the case at the time I did it.  I tested
> the idio^Wbandaid before submission.. mighta fscked up though :)

Erm... You pin the inode down. That makes filesystem busy by any
definition I can think of...

