Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273872AbRIRGaw>; Tue, 18 Sep 2001 02:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273874AbRIRGan>; Tue, 18 Sep 2001 02:30:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12930 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273872AbRIRGac>;
	Tue, 18 Sep 2001 02:30:32 -0400
Date: Tue, 18 Sep 2001 12:05:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre10aa1 (first spin to the vm rewrite included)
Message-ID: <20010918120559.A32241@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010917180914.I713@athlon.random> andrea@suse.de wrote:
> Some of the the main features of 2.4.10pre10aa1 are:

> o	rcu core included (thought it will be rewritten, I agreed with
> 	Dipankar that the per-cpu scheduling sequence number seems
> 	the best approch, such number can serve also as a statistic
> 	to usespace infact, it is very similar to Rusty's patch but it
> 	doesn't add any branch to the schedule fast path, he's rewriting
> 	the patch at the moment and I'll include it in the next release)

Sorry, in the latest patch I folded the per-cpu context switch counter into 
per-cpu counters for other quiescent states - user mode code and idle loop
in order to save on an extra compare making a single counter :-)
So, it is not much of a user space statistics anymore.

I can put that counter back, but I think eventually it may anyway
make sense to start using per-cpu statistics counters. As a matter
of fact we are working on a framework to support these. If we do
use per-cpu statistics counters later, RCU can make use of the
per-cpu context switch statistics counter.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
