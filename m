Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDKFT7>; Wed, 11 Apr 2001 01:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRDKFTu>; Wed, 11 Apr 2001 01:19:50 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:17680 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131233AbRDKFTg>;
	Wed, 11 Apr 2001 01:19:36 -0400
Date: Tue, 10 Apr 2001 23:22:13 -0600
From: yodaiken@fsmlabs.com
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: nigel@nrg.org, ak@suse.de, Dipankar Sarma <dipankar.sarma@in.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Suparna Bhattacharya <bsuparna@in.ibm.com>
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
Message-ID: <20010410232213.A8718@hq.fsmlabs.com>
In-Reply-To: <OFC444FA4A.28BB0BC6-ON88256A2B.0016B71E@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <OFC444FA4A.28BB0BC6-ON88256A2B.0016B71E@LocalDomain>; from Paul.McKenney@us.ibm.com on Tue, Apr 10, 2001 at 09:08:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 09:08:16PM -0700, Paul McKenney wrote:
> > Disabling preemption is a possible solution if the critical section is
> short
> > - less than 100us - otherwise preemption latencies become a problem.
> 
> Seems like a reasonable restriction.  Of course, this same limit applies
> to locks and interrupt disabling, right?

So supposing 1/2 us per update
	lock process list
		for every process update pgd
	unlock process list

is ok if #processes <  200, but can cause some unspecified system failure
due to a dependency on the 100us limit otherwise?

And on a slower machine or with some heavy I/O possibilities ....

We have a tiny little kernel to worry about inRTLinux and it's quite 
hard for us to keep track of all possible delays in such cases. How's this
going to work for Linux?

	
-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

