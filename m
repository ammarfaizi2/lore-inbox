Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292294AbSCGLc5>; Thu, 7 Mar 2002 06:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSCGLcr>; Thu, 7 Mar 2002 06:32:47 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:28338 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292294AbSCGLck>;
	Thu, 7 Mar 2002 06:32:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre2aa1
Date: Thu, 7 Mar 2002 12:27:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org
In-Reply-To: <20020307092119.A25470@dualathlon.random> <20020307104942.GC786@holomorphy.com>
In-Reply-To: <20020307104942.GC786@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iw3h-00037V-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2002 11:49 am, William Lee Irwin III wrote:
> On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> >	then let it scale more with the ram in the machine (the
> > 	amount of ram used for the wait table is ridicolously small and it
> > 	mostly depends on the amount of the I/O, not on the amount of ram, so
> > 	set up a low limit instead of an high limit).
> 
> The wait_table does not need to scale with the RAM on the machine
> 	It needs to scale with the number of waiters.
>
> 4096 threads blocked on I/O is already approaching or exceeding the
> scalability limits of other core kernel subsystems.

I think he meant that with larger ram it's easy to justify making the wait
table a little looser, to gain a tiny little bit of extra performance.

That seems perfectly reasonable to me.  Oh, and there's also the observation
that machines with larger ram tend to be more heavily loaded with processes,
just because one can.

--
Daniel
