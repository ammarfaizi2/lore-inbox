Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288637AbSADODc>; Fri, 4 Jan 2002 09:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288632AbSADODX>; Fri, 4 Jan 2002 09:03:23 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:30460 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S288635AbSADODM>; Fri, 4 Jan 2002 09:03:12 -0500
Date: Fri, 4 Jan 2002 08:02:43 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201041402.IAA80257@tomcat.admin.navo.hpc.mil>
To: petro@auctionwatch.com, Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Two hdds on one channel - why so slow?
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petro <petro@auctionwatch.com>:
> On Wed, Jan 02, 2002 at 08:52:31PM -0500, Mark Hahn wrote:
> > On Wed, 2 Jan 2002, Ricky Beam wrote:
> > > PS: I once turned down a 360MHz Ultra10 in favor of a 167MHz Ultra1 because
> > >     of the absolutely shitty IDE performance.  The U1 was actually faster
> > >     at compiling software. (Solaris 2.6, btw)
> > yeah, if Sun can't make IDE scream, then no one can eh?
> 
>     If SCSI had the economy of scale that IDE enjoys, it would be a lot
>     cheaper than it is now. Not as cheap as IDE currently is, but still
>     a lot cheaper. 
> 
>     ATA/IDE is trying pick and choose the best parts of SCSI w/out
>     picking up the costs--which is an admirable goal. The question is
>     how close can they get w/out incurring the costs? 

About the time it attempts to support 16-60 drives on one controller
(15 targets, 4 luns per target), with full asynchronous operation.

The costs start accumulating with the async operation.

I've always treated IDE as only part - the controller sharing the equivalent
of a single SCSI target, with two luns. The PCI interface appears about
equivalent to that of the SCSI controller, but the IDE controller completely
drops the multiple target feature (as well as the shared data/command bus).

IDE boards with 4 drives seem to be two IDE controllers using the same PCI
interface. 

In my experience, SCSI is not cost effective for systems with a single disk.
As soon as you go to 4 or more disks, the throughput of SCSI takes over unless
you are expanding a pre-existing workstation configuration.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
