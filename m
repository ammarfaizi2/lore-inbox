Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282523AbRLFTbG>; Thu, 6 Dec 2001 14:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282654AbRLFTbB>; Thu, 6 Dec 2001 14:31:01 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18065 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282523AbRLFTar>; Thu, 6 Dec 2001 14:30:47 -0500
Date: Fri, 7 Dec 2001 01:05:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011207010558.A13412@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <OF29EF801E.F851F18D-ON85256B19.00510775@raleigh.ibm.com> <20011206180353.E20583@in.ibm.com> <3C0F6D99.8CF24014@redhat.com> <20011206193940.F20583@in.ibm.com> <20011206091015.B16763@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206091015.B16763@devserv.devel.redhat.com>; from arjanv@redhat.com on Thu, Dec 06, 2001 at 09:10:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 09:10:15AM -0500, Arjan van de Ven wrote:
> On Thu, Dec 06, 2001 at 07:39:40PM +0530, Ravikiran G Thirumalai wrote:
> > But, you cannot deny that there r gonna be a lot of cacheline 
> > invalidations, if you use a global counter.  Using per-cpu versions is
> > definitely going to improve kernel performance.
> 
> there's not that many counters in fact. And if you care about a gige
> counter, just bind the card to a specific CPU and you have ad-hoc per-cpu
> counters...
> 
> The extra cost of getting to them (extra indirection) makes each access 
> more expensive..... in the end it might be a loss.

If it is a low frequency statistics then the expensive access wouldn't 
really matter much, right ? On the other hand, this will likely help 
specially with larger number of CPUs.

> 
> There's several things where per cpu data is useful; low frequency
> statistics is not one of them in my opinion. 

It is quite possible that you are right. What we need to do is
a measurement effort to understand the impact.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
