Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288465AbSADCyx>; Thu, 3 Jan 2002 21:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288468AbSADCyn>; Thu, 3 Jan 2002 21:54:43 -0500
Received: from ns2.auctionwatch.com ([64.14.24.2]:30984 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S288465AbSADCy0>; Thu, 3 Jan 2002 21:54:26 -0500
Date: Thu, 3 Jan 2002 18:54:24 -0800
From: Petro <petro@auctionwatch.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Message-ID: <20020104025424.GP28238@auctionwatch.com>
In-Reply-To: <Pine.GSO.4.33.0201021812560.28783-100000@sweetums.bluetronic.net> <Pine.LNX.4.33.0201022010340.10236-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201022010340.10236-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 08:52:31PM -0500, Mark Hahn wrote:
> On Wed, 2 Jan 2002, Ricky Beam wrote:
> > It takes expensive hardware RAID cards to make IDE tolerable. (and
> > I'm not talking about the 30$ PoS HPT crap.)
> besides having missed the last 2-3 generations of ATA (which include
> things like diskconnect), you have clearly not noticed that entry-level
> hardware with PoS UDMA100 controllers can sustain more bandwidth than
> you can hope to consume (120 MB/s is pretty easy, even on 32x33 PCI!)

    It's not always bandwidth (raw IO) that is the problem. We've got
    a couple clusters where a 3ware 64xx w/4 IBM GXPs in raid0 cannot
    keep up with the "load" of Mysql doing lots of ops on lots of files. 

    Yeah, it's not just how much load, but what kind of load. Streaming
    a 3 gig file into memory, then dumping a 3 gig file to disk is a lot
    different than opening 3000 1 meg files, twitching a bit and then
    closing them. 

    I like our 3ware controllers, they've allowed us to migrate a off a
    whole bunch of Sun Hardware, and saved us a whole bunch of money,
    but on our loaded machines, we've lost a lot of sleep (of course
    some of that seems to be due to memory corruption issues as well.)

> > PS: I once turned down a 360MHz Ultra10 in favor of a 167MHz Ultra1 because
> >     of the absolutely shitty IDE performance.  The U1 was actually faster
> >     at compiling software. (Solaris 2.6, btw)
> yeah, if Sun can't make IDE scream, then no one can eh?

    If SCSI had the economy of scale that IDE enjoys, it would be a lot
    cheaper than it is now. Not as cheap as IDE currently is, but still
    a lot cheaper. 

    ATA/IDE is trying pick and choose the best parts of SCSI w/out
    picking up the costs--which is an admirable goal. The question is
    how close can they get w/out incurring the costs? 
-- 
Share and Enjoy. 
