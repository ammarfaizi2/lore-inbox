Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274182AbRISUzP>; Wed, 19 Sep 2001 16:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274185AbRISUzG>; Wed, 19 Sep 2001 16:55:06 -0400
Received: from [195.223.140.107] ([195.223.140.107]:55800 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274182AbRISUzA>;
	Wed, 19 Sep 2001 16:55:00 -0400
Date: Wed, 19 Sep 2001 22:55:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010919225505.P720@athlon.random>
In-Reply-To: <20010919202539.E720@athlon.random> <Pine.GSO.4.21.0109191515200.901-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109191515200.901-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Sep 19, 2001 at 03:21:09PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 03:21:09PM -0400, Alexander Viro wrote:
> 
> 
> On Wed, 19 Sep 2001, Andrea Arcangeli wrote:
> 
> > Quite frankly the BDEV_* handling was and is a total mess IMHO, even if
> > it was written by you ;), there was no difference at all from many of
> > them, I didn't fixed that but I had to check all them on the differences
> > until I realized there was none. I also think the other things you
> 
> There certainly _are_ differences  (e.g. in handling the moment
> when you close them).

there aren't difference, only thing that matters is: "is that an fs
or a blkdev". SWAP/RAW/FILE is useless.

> > mentioned (besides the inode pinning bug, non critical) are not buggy
> 
> _What_?
> 
> int fd = open("/dev/ram0", O_RDWR);
> ioctl(fd, BLKFLSBUF);
> ioctl(fd, BLKFLSBUF);
> 
> and you claim that resulting oops is not a bug?

that is a bug.

> > (infact I never had a single report), but well we'll verify that in
> 
> Richard, is that you?  What had you done with real Andrea?

You also screwup things sometime (think the few liner you posts to l-k
after your cleanups).  Those are minor bugs, so I'm not going to panic
on them (ramdisk works not by luck), this is what I meant, and they will
be fixed shortly somehow, and many thanks for the further auditing.

Andrea
