Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319021AbSIKOTx>; Wed, 11 Sep 2002 10:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSIKOTx>; Wed, 11 Sep 2002 10:19:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3066 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319021AbSIKOTv>;
	Wed, 11 Sep 2002 10:19:51 -0400
Date: Wed, 11 Sep 2002 19:59:39 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read-Copy Update 2.5.34
Message-ID: <20020911195939.E28198@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020911164940.C28198@in.ibm.com> <Pine.LNX.4.44.0209111323360.12332-100000@localhost.localdomain> <20020911175011.D28198@in.ibm.com> <1031753011.950.106.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1031753011.950.106.camel@phantasy>; from rml@tech9.net on Wed, Sep 11, 2002 at 10:03:28AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 10:03:28AM -0400, Robert Love wrote:
> On Wed, 2002-09-11 at 08:20, Dipankar Sarma wrote:
> 
> > 			vanilla-2.5.34	rcu_poll-2.5.34
> > 			--------------  ---------------
> > 80 , 40 , 		1.593		1.569
> > 112 , 40 , 		1.544		1.554
> > 144 , 40 , 		1.595		1.552
> > 176 , 40 , 		1.568		1.605
> > 198 , 40 , 		1.562		1.577
> > 230 , 40 , 		1.563		1.583
> > 244 , 40 , 		1.671		1.638
> > 
> > Not sure how reliable these numbers are.
> 
> And how bad is the performance drop from 2.5.34-preempt to
> 2.5.34-preempt-rcu?
> 
> I am glad you guys support kernel preemption (not that you have a chance
> at this point) but I hope it was not an afterthought.

Hi Robert,

Sorry, I should have been more careful labelling them - those are 2.5.34-preempt
vs 2.5.34-preempt-rcu numbers. I did them first because rcu-poll-preempt
kernel has a conditinal branch in fast path and hence more interesting. 
I will publish the vanilla vs rcu_poll reflex numbers in a few minutes 
from now.

The preemption support have been in RCU for a very long time. IIRC, I added
it in around 2.5.14.

See http://marc.theaimsgroup.com/?l=linux-kernel&m=102084967517192&w=2

Our OLS paper and presentation too deals with preemption -

http://www.rdrop.com/users/paulmck/rclock/rcu.2002.07.08.pdf
http://www.rdrop.com/users/paulmck/rclock/rclock.OLS.2002.07.08a.pdf

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
