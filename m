Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRIPJYR>; Sun, 16 Sep 2001 05:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRIPJYI>; Sun, 16 Sep 2001 05:24:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42254 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S269481AbRIPJXx>;
	Sun, 16 Sep 2001 05:23:53 -0400
Date: Sun, 16 Sep 2001 11:24:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: kelley eicher <keicher@nws.gov>, J <jack@i2net.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 0-order allocation failed in 2.4.10-pre8
Message-ID: <20010916112414.A7402@suse.de>
In-Reply-To: <3BA24EB0.5000402@i2net.com> <20010916015917Z16125-2757+260@humbolt.nl.linux.org> <20010916100325.B1045@suse.de> <20010916091402Z16065-2757+289@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010916091402Z16065-2757+289@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16 2001, Daniel Phillips wrote:
> On September 16, 2001 10:03 am, Jens Axboe wrote:
> > On Sun, Sep 16 2001, Daniel Phillips wrote:
> > > > Use the
> > > > 
> > > > 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-highmem-all
> > > > 
> > > > patch and you can use highmem without having to worry about failed
> > > > 0-order bounce pages allocations.
> > > 
> > > Right, by using 64 bit DMA instead of bounce buffers.  But aren't there 
> cases
> > > where the 64 bit capable hardware isn't there but somebody still wants to 
> use
> > > highmem?
> > 
> > Yes of course. The common case is not 64-bit dma here though, it's just
> > being able to DMA to highmem pages (just full 32-bit dma instead of low
> > memory dma). And that should cover most systems out there.
> 
> Right, but that does not mean we can forget about bounce buffers, does it.  
> Most users will probably be able to use full 32-bit dma and users with more 
> than 4 GB of memory really should go to the effort of making sure their 
> hardware supports 64 bit dma.  But there will still be a few people who have 
> to use bounce buffers.

Of course. My point was merely what with the block-highmem patch, most
users will never need bounce -> it would therefore solve the posters
issue.

> I'm just confirming that we really do have to push on and get bounce buffers 
> working reliably, even if most people will be able to use your far nicer 
> alternative.

Agreed. It will be much less important, but there will still be a need
for it.

-- 
Jens Axboe

