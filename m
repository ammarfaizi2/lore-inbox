Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283722AbRK3Riv>; Fri, 30 Nov 2001 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283723AbRK3Rim>; Fri, 30 Nov 2001 12:38:42 -0500
Received: from www.wen-online.de ([212.223.88.39]:2056 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S283722AbRK3Rih>;
	Fri, 30 Nov 2001 12:38:37 -0500
Date: Fri, 30 Nov 2001 17:39:39 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17pre1aa1
In-Reply-To: <3C068476.480BC2AD@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111301726390.3362-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Andrew Morton wrote:

> Andrea Arcangeli wrote:
> >
> > Only in 2.4.15aa1: 10_vm-17
> > Only in 2.4.17pre1aa1: 10_vm-18
> >
> >         Minor vm tweaks in function of the feedback received.
> >         Included Andrews' dirty += BUF_LOCKED.
> >
>
> OK.  One think I notice is that you've also decreased nfract,nfract_sync
> from (40%,60%) to (20%,40%).  So taken together, these changes mean
> that we'll start writeout much earlier, and will block writers much
> earlier.  What's the thinking here?
>
> I received some interesting results from Mike Galbraith today.

2.4.17-pre1aa1
real    7m39.066s
user    6m38.400s
sys     0m29.140s

user  :       0:06:44.82  76.1%  page in :   536247
nice  :       0:00:00.00   0.0%  page out:   466800
system:       0:00:45.45   8.5%  swap in :   106783
idle  :       0:01:21.89  15.4%  swap out:   111683

__alloc_pages: 0-order allocation failed (gfp=0xf0/0)   (only the one)

IO contrast...

2.5.1-pre1
real    7m54.873s
user    6m41.070s
sys     0m30.170s

user  :       0:06:47.35  72.6%  page in :   661891
nice  :       0:00:00.00   0.0%  page out:   708836
system:       0:00:47.42   8.5%  swap in :   140234
idle  :       0:01:46.26  18.9%  swap out:   172775

	-Mike

