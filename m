Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319223AbSIKQZ0>; Wed, 11 Sep 2002 12:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319224AbSIKQZ0>; Wed, 11 Sep 2002 12:25:26 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:5786 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319223AbSIKQZY>;
	Wed, 11 Sep 2002 12:25:24 -0400
Date: Wed, 11 Sep 2002 22:05:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read-Copy Update 2.5.34
Message-ID: <20020911220514.G28198@in.ibm.com>
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
> > Not sure how reliable these numbers are.
> 
> And how bad is the performance drop from 2.5.34-preempt to
> 2.5.34-preempt-rcu?

Hi Robert,

Here are the detailed results from reflex benchmark all with
2.5.34 kernel and 4CPU p3 xeon with 1MB L2 cache and 1GB RAM.

 		vanilla-preempt	rcu_poll-preempt vanilla  rcu_poll
		--------------	---------------- -------  --------
80 , 40 , 		1.593	1.569		 1.545	  1.536
112 , 40 , 		1.544	1.554		 1.544	  1.535
144 , 40 , 		1.595	1.552		 1.545    1.586
176 , 40 , 		1.568	1.605		 1.615	  1.536
198 , 40 , 		1.562	1.577		 1.582	  1.651
230 , 40 , 		1.563	1.583		 1.581	  1.554
244 , 40 , 		1.671	1.638		 1.631	  1.571


> 
> I am glad you guys support kernel preemption (not that you have a chance
> at this point) but I hope it was not an afterthought.
> 

Forgot to mention, earlier implementations of RCU like in K42 had complete
preemption support, so the linux implementation is not really new.
We added it after preemption support went into Linus' tree.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
