Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131316AbRCHJwo>; Thu, 8 Mar 2001 04:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRCHJwe>; Thu, 8 Mar 2001 04:52:34 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:51639 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S131316AbRCHJwP>;
	Thu, 8 Mar 2001 04:52:15 -0500
Date: Thu, 8 Mar 2001 10:51:41 +0100
From: David Weinehall <tao@acc.umu.se>
To: Jens Axboe <axboe@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 64-bit capable block device layer
Message-ID: <20010308105140.B18769@khan.acc.umu.se>
In-Reply-To: <20010307184749.A4653@suse.de> <Pine.LNX.4.33.0103071504250.1409-100000@duckman.distro.conectiva> <20010307195323.D4653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010307195323.D4653@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 07:53:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 07:53:23PM +0100, Jens Axboe wrote:
> On Wed, Mar 07 2001, Rik van Riel wrote:
> > > > how would you feel about having the block device layer 64-bit
> > > > capable, so Linux can have block devices of more than 2GB in
> > > > size ?
> > >
> > > I already did this here, or something similar at least. Using
> > > a sector_t type that is 64-bit, regardless of platform. Is it
> > > really worth it to differentiate and use 32-bit types for old
> > > machines?
> > 
> > Wonderful !
> > 
> > I'm not sure how expensive 64-bit arithmetic would be on
> > eg. 386, 486 or 68k machines, or how much impact the extra
> > memory taken would have.
> > 
> > OTOH, I'm not sure what problems it could give to make this
> > a compile-time option...
> 
> Plus compile time options are nasty :-). It would probably make
> bigger sense to completely skip all the merging etc for low end
> machines. I think they already do this for embedded kernels (ie
> removing ll_rw_blk.c and elevator.c). That avoids most of the
> 64-bit arithmetic anyway.

My 386/486 and m68k-machines with 4/8/16 MB's of memory would be happy
for any and all options to remove code only needed by larger machines.
I'm pretty sure none of my 386:en will ever have 2GB of swap, 2GB of
blockdevices or 2TB filesystems...

Of course, for embedded kernels, being able to exclude block-devices
might be an idea. Or?


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
