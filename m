Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262560AbREZCuT>; Fri, 25 May 2001 22:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262557AbREZCuJ>; Fri, 25 May 2001 22:50:09 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:38510 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262554AbREZCuA>; Fri, 25 May 2001 22:50:00 -0400
Date: Fri, 25 May 2001 22:49:38 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526043835.R9634@athlon.random>
Message-ID: <Pine.LNX.4.33.0105252243570.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> Allocating a buffer head during out of memory is always been deadlock
> prone, 2.2 always had the same problem too. I'm not sure why you are
> telling me this, I didn't changed anything that happens to be in the
> swapout path (besides removing the deadlock in create_bounces with
> evolution of first Ingo's patch but that is not specific to the
> swapout). I only changed the getblk path (which is not used by the
> swapout, at least unless you swapout on a file not on a blkdev, but even
> in that case the change is fine).

Highmem.  0 free pages in ZONE_NORMAL.  Now try to allocate a buffer_head.
Running under heavy load runs into this even after there is a highmem
bounce buffer pool.

> btw in the below patch __GFP_FAIL is a noop.

<shrug>  merge that patch from -ac then.

		-ben

