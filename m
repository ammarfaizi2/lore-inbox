Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSGSWCb>; Fri, 19 Jul 2002 18:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSGSWCb>; Fri, 19 Jul 2002 18:02:31 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46214 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317101AbSGSWCa>; Fri, 19 Jul 2002 18:02:30 -0400
Date: Fri, 19 Jul 2002 16:05:29 -0600
Message-Id: <200207192205.g6JM5TR12776@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: frankeh@watson.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, shreenivasa H V <shreenihv@usa.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Gang Scheduling in linux
In-Reply-To: <200207191525.40633.frankeh@watson.ibm.com>
References: <Pine.LNX.4.44.0207201858180.17247-100000@localhost.localdomain>
	<200207191525.40633.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke writes:
> On a single SMP I could imagine for instance for parallel reendering
> or similar tightly integrated parallel programs that need data
> synchronization.  Most of these apps assume a tightly coupled
> non-virtual resource, i.e., scheduling of tasks is aligned.
> 
> SGI used to have that stuff in their base kernel. Read a paper about
> this some years ago.  Again, at the beginning I'd go with a user
> level scheduler approach that certainly would satisfy national labs
> etc. Most of the cluster schedulers, like PBS and LoadLeveler etc.,
> already provide that functionality.

A completely user-level solution may have some disadvantages, though,
such as delays in scheduling on/off (say if some daemon is used to
scan the process list). Perhaps we could add a small hack to the
scheduler such that when a task is about to be scheduled off, a signal
can be sent to a designated pid? Similarly, when a task is scheduled
on, another signal may be sent. An application that wanted to have
gang scheduling could then make use of this to STOP/CONT threads.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
