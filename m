Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291084AbSCDDKS>; Sun, 3 Mar 2002 22:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291086AbSCDDKJ>; Sun, 3 Mar 2002 22:10:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12806 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291084AbSCDDKF>;
	Sun, 3 Mar 2002 22:10:05 -0500
Message-ID: <3C82E5A1.714081EA@mandrakesoft.com>
Date: Sun, 03 Mar 2002 22:10:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Steve Lord <lord@sgi.com>
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On March 1, 2002 09:26 am, Andrew Morton wrote:
> > A bunch of patches which implement allocate-on-flush for 2.5.6-pre1 are
> > available at http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-10-core.patch
> >   - Core functions
> > and
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-20-ext2.patch
> >   - delalloc implementation for ext2.

> Wow, this is massive.  Why did you write [patch] instead of [PATCH]? ;-) I'm
> surprised there aren't any comments on this patch so far, that should teach
> you to post on a Friday afternoon.

My only comment is: how fast can we get delalloc into 2.5.x for further
testing and development?

IMNSHO there are few comments because I believe that few people actually
realize the benefits of delalloc.  My ext2 filesystem with --10--
percent fragmentation could sure use code like this, though.


> >   But it may come unstuck when applied to swapcache.
> 
> You're not even trying to apply this to swap cache right now are you?

This is a disagreement akpm and I have, actually :)

I actually would rather that it was made a requirement that all
swapfiles are "dense", so that new block allocation NEVER must be
performed when swapping.


> There is also my nefarious plan to make
> struct pages refer to variable-binary-sized objects, including smaller than
> 4K PAGE_SIZE.

sigh...

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
