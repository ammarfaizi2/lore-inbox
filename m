Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274139AbRISTVO>; Wed, 19 Sep 2001 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274142AbRISTVF>; Wed, 19 Sep 2001 15:21:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26284 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274139AbRISTUt>;
	Wed, 19 Sep 2001 15:20:49 -0400
Date: Wed, 19 Sep 2001 15:21:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010919202539.E720@athlon.random>
Message-ID: <Pine.GSO.4.21.0109191515200.901-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Sep 2001, Andrea Arcangeli wrote:

> Quite frankly the BDEV_* handling was and is a total mess IMHO, even if
> it was written by you ;), there was no difference at all from many of
> them, I didn't fixed that but I had to check all them on the differences
> until I realized there was none. I also think the other things you

There certainly _are_ differences  (e.g. in handling the moment
when you close them).

> mentioned (besides the inode pinning bug, non critical) are not buggy

_What_?

int fd = open("/dev/ram0", O_RDWR);
ioctl(fd, BLKFLSBUF);
ioctl(fd, BLKFLSBUF);

and you claim that resulting oops is not a bug?

> (infact I never had a single report), but well we'll verify that in

Richard, is that you?  What had you done with real Andrea?

