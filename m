Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273179AbRIPIDq>; Sun, 16 Sep 2001 04:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273176AbRIPID0>; Sun, 16 Sep 2001 04:03:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14605 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273174AbRIPIDX>;
	Sun, 16 Sep 2001 04:03:23 -0400
Date: Sun, 16 Sep 2001 10:03:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: kelley eicher <keicher@nws.gov>, J <jack@i2net.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 0-order allocation failed in 2.4.10-pre8
Message-ID: <20010916100325.B1045@suse.de>
In-Reply-To: <3BA24EB0.5000402@i2net.com> <Pine.LNX.4.33.0109141342340.14906-100000@home.nohrsc.nws.gov> <20010914210903.E806@suse.de> <20010916015917Z16125-2757+260@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010916015917Z16125-2757+260@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16 2001, Daniel Phillips wrote:
> > Use the
> > 
> > *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-highmem-all
> > 
> > patch and you can use highmem without having to worry about failed
> > 0-order bounce pages allocations.
> 
> Right, by using 64 bit DMA instead of bounce buffers.  But aren't there cases
> where the 64 bit capable hardware isn't there but somebody still wants to use
> highmem?

Yes of course. The common case is not 64-bit dma here though, it's just
being able to DMA to highmem pages (just full 32-bit dma instead of low
memory dma). And that should cover most systems out there.

-- 
Jens Axboe

