Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280994AbRKGVdY>; Wed, 7 Nov 2001 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280991AbRKGVdQ>; Wed, 7 Nov 2001 16:33:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63983
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280994AbRKGVdH>; Wed, 7 Nov 2001 16:33:07 -0500
Date: Wed, 7 Nov 2001 13:33:01 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107133301.C20245@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>, <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE99650.70AF640E@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 12:15:12PM -0800, Andrew Morton wrote:
> Anton Altaparmakov wrote:
> > 
> > At 19:12 07/11/2001, Alan Cox wrote:
> > > > when coming back up it fscked (I didn't touch anything - didn't even
> > > notice
> > > > any 5 second thing but I wasn't looking at this screen) and it found two
> > > > lost inodes (I got two entries in lost and found). So it still needs to
> > > > fsck by the looks of it?
> > >
> > >That sounds like you used your own kernel with it and had ext2 mounting
> > >the root fs (remember its back compatible)
> > 
> > Yes, that makes a lot of sense. After the reset I went into my own kernel
> > with both ext2 and ext3 compiled into it. However, before the reboot, I was
> > still in the RH kernel (99% sure it was so, but my memory might be
> > deceiving me).
> > 
> > Is there any Right Way(TM) to fix this situation considering I want to have
> > both ext2 and ext3 in my kernels (apart from the obvious of changing the
> > order fs are called during root mount in the kernel)?
> > 
> 
> There's a fair bit of material on this at
> 
> 	http://www.uow.edu.au/~andrewm/linux/ext3/ext3-usage.html
> 
> executive summary:
> 
> 	- use latest util-linux and e2fsprogs
> 	- Make the root fs have fstype `ext3' in /etc/fstab
> 	- Make the others `auto'
> 	- Alternatively, use "ext3,ext2" in fstab.
> 

I have a switch "data=journal" that ext2 will choke on when I boot into an
ext2 only kernel.

Is there another way to change the journaling mode besides modifying
/etc/fstab?

It'd be nice if it could be a compile time switch for default journal mode...

Mike
