Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285148AbRLFOKt>; Thu, 6 Dec 2001 09:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285146AbRLFOK3>; Thu, 6 Dec 2001 09:10:29 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:22372 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285143AbRLFOKT>; Thu, 6 Dec 2001 09:10:19 -0500
Date: Thu, 6 Dec 2001 09:10:15 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011206091015.B16763@devserv.devel.redhat.com>
In-Reply-To: <OF29EF801E.F851F18D-ON85256B19.00510775@raleigh.ibm.com> <20011206180353.E20583@in.ibm.com> <3C0F6D99.8CF24014@redhat.com> <20011206193940.F20583@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206193940.F20583@in.ibm.com>; from kiran@in.ibm.com on Thu, Dec 06, 2001 at 07:39:40PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 07:39:40PM +0530, Ravikiran G Thirumalai wrote:
> Well, as I mentioned in my earlier post, we have performed 
> "micro benchmarking", which does not reflect the actual run time
> kernel conditions. I guess u gotta take these results with a 
> pinch of salt.  
> 
> But, you cannot deny that there r gonna be a lot of cacheline 
> invalidations, if you use a global counter.  Using per-cpu versions is
> definitely going to improve kernel performance.

there's not that many counters in fact. And if you care about a gige
counter, just bind the card to a specific CPU and you have ad-hoc per-cpu
counters...

The extra cost of getting to them (extra indirection) makes each access 
more expensive..... in the end it might be a loss.

There's several things where per cpu data is useful; low frequency
statistics is not one of them in my opinion. 

Greetings,
   Arjan van de Ven
