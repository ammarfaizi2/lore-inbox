Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293691AbSCATwC>; Fri, 1 Mar 2002 14:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293682AbSCATvr>; Fri, 1 Mar 2002 14:51:47 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:64988 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S293685AbSCATuz>; Fri, 1 Mar 2002 14:50:55 -0500
Date: Fri, 1 Mar 2002 14:50:52 -0500 (EST)
From: Bharath Krishnan <bharath@MIT.EDU>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Yet another disk transfer speed problem
In-Reply-To: <3C7F43BE.B0D2EAE@aitel.hist.no>
Message-ID: <Pine.GSO.4.30L.0203011448420.3706-100000@stymie.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I may have been overly simplistic/ignorant in my reasoning.

But, in this case, the slow disk is rated pretty high in performance. It
can supposedly do 40MB/sec. Maxtor sells it as D740X, their performance
range.


Thanks,


-bharath

 On Fri, 1 Mar 2002, Helge Hafting wrote:

> Bharath Krishnan wrote:
> >
> > Hi,
> >
> > I would expect the disk which acts slower(maxtor) to be atleast as fast
> > as the other one (ibm).
> >
> > reasons:
> >
> > 1. Both are 7200RPM
> Not enough to get anywhere near equal performance.
> This also depends on how densely data is packed onto a single track.
> A 7200 RPM drive reads a whole track in 1/7200 minute, or 1/120 second.
> That limits the maximum speed - but how much data is there
> on a single track?  Slow 7200 RPM drives have many tracks and little
> data on each track.  Fast drives have fewer tracks and more
> data in each.  Note that this has nothing to do with disk geometry
> reported by hdparm, that geometry is just a lie.
> All new drives have a varying amount of data per track as the
> outermost tracks are longer than the innermost.
> That of course also means the speed varies a lot depending on
> _what_ track is used for testing.
>
> My atlas IV scsi drive does 21MB/s on the outer tracks and 15MB/s
> on the inner tracks according to specs.  Running bonnie tests
> on partitions at either end of the drive confirms the difference.
>
> So, expect 7200 RPM drives from different manufacturers to
> have very different transfer speeds.  Or even different sized
> drives from the same.
>
> > 2. The slower one(maxtor hdg) is one of the newer ata133 disks while
> > that faster one  is ata100(ibm hde). I would expect atleast equal
> > performance from both.
>
>
> 133 or 100 sets an upper limit of 133 or 100MB/s for sure, but that
> doesn't matter _at all_ because the platters aren't that fast
> anyway.  The best you'll ever get depends on how much data they fit
> on the outermost track.  The 133 interface will be 33% faster when
> transferring small amounts of data to or from the drive's internal
> cache, but it won't impact transfers bigger than the cacee size
> at all.  hdparms 64M test is bigger than the drive's internal cache
> which probably is a few megs only.
>
> Helge Hafting
>

-bharath





