Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285138AbRLFOGj>; Thu, 6 Dec 2001 09:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285139AbRLFOGd>; Thu, 6 Dec 2001 09:06:33 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13752 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285138AbRLFOFn>; Thu, 6 Dec 2001 09:05:43 -0500
Date: Thu, 6 Dec 2001 19:39:40 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011206193940.F20583@in.ibm.com>
In-Reply-To: <OF29EF801E.F851F18D-ON85256B19.00510775@raleigh.ibm.com> <20011206180353.E20583@in.ibm.com> <3C0F6D99.8CF24014@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0F6D99.8CF24014@redhat.com>; from arjanv@redhat.com on Thu, Dec 06, 2001 at 01:07:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 01:07:37PM +0000, Arjan van de Ven wrote:
> > 
> > >
> > > How many and which counters were converted for the test you refer to?
> > >
> > 
> > Well, I wrote a simple kernel module which just increments a shared global
> > counter a million times per processor in parallel, and compared it with
> > the statctr which would be incremented a million times per processor in
> > parallel..
> 
> Would you care to point out a statistic in the kernel that is
> incremented 
> more than 10.000 times/second ? (I'm giving you a a factor of 100 of
> playroom 
> here) [One that isn't per-cpu yet of course]

Well, as I mentioned in my earlier post, we have performed 
"micro benchmarking", which does not reflect the actual run time
kernel conditions. I guess u gotta take these results with a 
pinch of salt.  

But, you cannot deny that there r gonna be a lot of cacheline 
invalidations, if you use a global counter.  Using per-cpu versions is
definitely going to improve kernel performance.

Kiran

-- 
Ravikiran G Thirumalai <kiran@in.ibm.com>
Linux Technology Center, IBM Software Labs,
Bangalore.
