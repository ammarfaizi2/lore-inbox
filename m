Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292297AbSBBPHN>; Sat, 2 Feb 2002 10:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292296AbSBBPHD>; Sat, 2 Feb 2002 10:07:03 -0500
Received: from brick.kernel.dk ([195.249.94.204]:65172 "EHLO
	burns.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S292297AbSBBPGx>; Sat, 2 Feb 2002 10:06:53 -0500
Date: Sat, 2 Feb 2002 16:06:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Roger Larsson <roger.larsson@norran.net>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Errors in the VM - detailed
Message-ID: <20020202160641.E4934@suse.de>
In-Reply-To: <20020202154449.D4934@suse.de> <Pine.LNX.4.30.0202021602001.10631-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0202021602001.10631-100000@mustard.heime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02 2002, Roy Sigurd Karlsbakk wrote:
> On Sat, 2 Feb 2002, Jens Axboe wrote:
> 
> > On Sat, Feb 02 2002, Roy Sigurd Karlsbakk wrote:
> > > > Jens said earlier "Roy, please try and change
> > > > the queue_nr_requests assignment in ll_rw_blk:blk_dev_init() to
> > > > something like 2048." - Roy have you tested this too?
> > >
> > > No ... Where do I change it?
> >
> > drivers/block/ll_rw_blk.c:blk_dev_init()
> > {
> > 	queue_nr_requests = 64;
> > 	if (total_ram > MB(32))
> > 		queue_nr_requests = 256;
> >
> > Change the 256 to 2048.
> 
> Is this an attempt to fix the problem #2 (as described in the initial
> email), or to further improve throughtput?

Further "improvement", the question is will it make a difference.
Bumping READA count would interesting too, as outlined.

> Problem #2 is _the_ worst problem, as it makes the server more-or-less
> unusable

Please send sysrq-t traces for such stuck processes. It's _impossible_
to guess whats going on from here, the crystal ball just isn't good
enough :-)

-- 
Jens Axboe

