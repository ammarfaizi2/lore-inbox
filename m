Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136111AbRECGYm>; Thu, 3 May 2001 02:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136124AbRECGYc>; Thu, 3 May 2001 02:24:32 -0400
Received: from mail0.bna.bellsouth.net ([205.152.150.12]:37286 "EHLO
	mail0.bna.bellsouth.net") by vger.kernel.org with ESMTP
	id <S136111AbRECGYU>; Thu, 3 May 2001 02:24:20 -0400
From: volodya@mindspring.com
Date: Thu, 3 May 2001 02:23:35 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.20.0105030221050.5590-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Linus Torvalds wrote:

> 
> 
> On Thu, 26 Apr 2001, Alexander Viro wrote:
> > On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> > >
> > > how can the read in progress see a branch that we didn't spliced yet? We
> >
> > fd = open("/dev/hda1", O_RDONLY);
> > read(fd, buf, sizeof(buf));
> 
> Note that I think all these arguments are fairly bogus.  Doing things like
> "dump" on a live filesystem is stupid and dangerous (in my opinion it is
> stupid and dangerous to use "dump" at _all_, but that's a whole 'nother
> discussion in itself), and there really are no valid uses for opening a
> block device that is already mounted. More importantly, I don't think
> anybody actually does.

Actually I did. I might do it again :) The point was to get the kernel to
cache certain blocks in the RAM. 

                                     Vladimir Dergachev

> 
> The fact that you _can_ do so makes the patch valid, and I do agree with
> Al on the "least surprise" issue. I've already applied the patch, in fact.
> But the fact is that nobody should ever do the thing that could cause
> problems.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

