Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132535AbRDKIiN>; Wed, 11 Apr 2001 04:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132545AbRDKIiD>; Wed, 11 Apr 2001 04:38:03 -0400
Received: from nrg.org ([216.101.165.106]:12870 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132535AbRDKIh6>;
	Wed, 11 Apr 2001 04:37:58 -0400
Date: Wed, 11 Apr 2001 01:37:48 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: yodaiken@fsmlabs.com
cc: Paul McKenney <Paul.McKenney@us.ibm.com>, ak@suse.de,
        Dipankar Sarma <dipankar.sarma@in.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Suparna Bhattacharya <bsuparna@in.ibm.com>
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <20010410232213.A8718@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.05.10104110119550.17755-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001 yodaiken@fsmlabs.com wrote:
> On Tue, Apr 10, 2001 at 09:08:16PM -0700, Paul McKenney wrote:
> > > Disabling preemption is a possible solution if the critical section is
> > short
> > > - less than 100us - otherwise preemption latencies become a problem.
> > 
> > Seems like a reasonable restriction.  Of course, this same limit applies
> > to locks and interrupt disabling, right?
> 
> So supposing 1/2 us per update
> 	lock process list
> 		for every process update pgd
> 	unlock process list
> 
> is ok if #processes <  200, but can cause some unspecified system failure
> due to a dependency on the 100us limit otherwise?

Only to a hard real-time system.

> And on a slower machine or with some heavy I/O possibilities ....

I'm mostly interested in Linux in embedded systems, where we have a lot
of control over the overall system, such as how many processes are
running.  This makes it easier to control latencies than on a
general purpose computer.

> We have a tiny little kernel to worry about inRTLinux and it's quite 
> hard for us to keep track of all possible delays in such cases. How's this
> going to work for Linux?

The same way everything works for Linux:  with enough people around the
world interested in and working on these problems, they will be fixed.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

