Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266698AbRGFNqV>; Fri, 6 Jul 2001 09:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266699AbRGFNqL>; Fri, 6 Jul 2001 09:46:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44808 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266698AbRGFNp7>;
	Fri, 6 Jul 2001 09:45:59 -0400
Date: Fri, 6 Jul 2001 15:45:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "ZINKEVICIUS,MATT (HP-Loveland,ex1)" <matt_zinkevicius@hp.com>
Subject: Re: patch: highmem zero-bounce
Message-ID: <20010706154552.G5889@suse.de>
In-Reply-To: <20010626182215.C14460@suse.de> <20010627114155.A31910@athlon.random> <20010627182745.D17905@suse.de> <20010627184908.E17905@suse.de> <20010627190626.E24623@athlon.random> <20010627191229.G17905@suse.de> <20010706154138.O2425@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010706154138.O2425@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06 2001, Andrea Arcangeli wrote:
> On Wed, Jun 27, 2001 at 07:12:29PM +0200, Jens Axboe wrote:
> > Humm yes, I agree. I'll redo it tonight and send an updated
> > incremental. Hopefully I'll be able to upload a new full version too.
> 
> I was going to integrate the avoid-bounce-buffer support but I don't
> find anything recent except the bio patch for 2.5 that you uploaded
> yesterday:
> 
> andrea@athlon:~/mirror/kernel.org/people/axboe > find -mtime -1 
> ./v2.5
> ./v2.5/bio-14-pre4
> andrea@athlon:~/mirror/kernel.org/people/axboe > find -mtime -25
> ./v2.5
> ./v2.5/bio-14-pre4
> andrea@athlon:~/mirror/kernel.org/people/axboe > 

Yes that's all yet, I haven't done a new block-highmem just for 2.4 just
yet.

> The bio patch would better be 2.5 material, I'd prefer only skipping the
> bounce between 1G to 4G in 2.4. Could you make a new patch with only the
> bounce skip between 1G and 4G against pre3?

Will do, but it will probably be after the weekend jfyi.

> btw, the latest bio patch from yesterday is still broken with respect to
> nested irqs:

[snip]

Duh yes thanks for looking at that, it's not surprising as I haven't
taken time to look at this properly yet. That's also why the 2.4 patch
wasn't ready as soon as I would've liked. Thanks!

-- 
Jens Axboe

