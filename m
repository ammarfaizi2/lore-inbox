Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131159AbRCGSyS>; Wed, 7 Mar 2001 13:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131160AbRCGSyI>; Wed, 7 Mar 2001 13:54:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62732 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131159AbRCGSx5>;
	Wed, 7 Mar 2001 13:53:57 -0500
Date: Wed, 7 Mar 2001 19:53:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 64-bit capable block device layer
Message-ID: <20010307195323.D4653@suse.de>
In-Reply-To: <20010307184749.A4653@suse.de> <Pine.LNX.4.33.0103071504250.1409-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0103071504250.1409-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Mar 07, 2001 at 03:12:17PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Rik van Riel wrote:
> > > how would you feel about having the block device layer 64-bit
> > > capable, so Linux can have block devices of more than 2GB in
> > > size ?
> >
> > I already did this here, or something similar at least. Using
> > a sector_t type that is 64-bit, regardless of platform. Is it
> > really worth it to differentiate and use 32-bit types for old
> > machines?
> 
> Wonderful !
> 
> I'm not sure how expensive 64-bit arithmetic would be on
> eg. 386, 486 or 68k machines, or how much impact the extra
> memory taken would have.
> 
> OTOH, I'm not sure what problems it could give to make this
> a compile-time option...

Plus compile time options are nasty :-). It would probably make
bigger sense to completely skip all the merging etc for low end
machines. I think they already do this for embedded kernels (ie
removing ll_rw_blk.c and elevator.c). That avoids most of the
64-bit arithmetic anyway.

-- 
Jens Axboe

