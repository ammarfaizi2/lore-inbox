Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281544AbRKPU12>; Fri, 16 Nov 2001 15:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281545AbRKPU1S>; Fri, 16 Nov 2001 15:27:18 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19606 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281544AbRKPU1E>; Fri, 16 Nov 2001 15:27:04 -0500
Date: Fri, 16 Nov 2001 13:26:21 -0700
Message-Id: <200111162026.fAGKQLM03728@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Real Time Runqueue
In-Reply-To: <20011116122005.E1152@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011116122005.E1152@w-mikek2.des.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz writes:
> As you may know, a few of us are experimenting with multi-runqueue
> scheduler implementations.  One area of concern is where to place
> realtime tasks.  It has been my assumption, that POSIX RT semantics
> require a specific ordering of tasks such as SCHED_FIFO and SCHED_RR.
> To accommodate this ordering, I further believe that the simplest
> solution is to ensure that all realtime tasks reside on the same
> runqueue.  In our MQ scheduler we have a separate runqueue for all
> realtime tasks.  The problem is that maintaining a separate realtime
> runqueue is a pain and results in some fairly complex/ugly code.
> 
> Since I'm not a realtime expert, I would like to ask if my assumption
> about strict ordering of RT tasks is accurate.  Also, is anyone aware
> of other ways to approach this problem?

Yes, strict ordering is required. Years ago I championed a separate
runqueue for RT tasks. Linus even said he liked the approach. I got
busy and never nursed it to inclusion. The patch is here:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.1/rtqueue-patch

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
