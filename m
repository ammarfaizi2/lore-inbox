Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272342AbRIKLsH>; Tue, 11 Sep 2001 07:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272375AbRIKLr6>; Tue, 11 Sep 2001 07:47:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:24960 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272342AbRIKLrp>; Tue, 11 Sep 2001 07:47:45 -0400
Date: Tue, 11 Sep 2001 17:23:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org, Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911172301.A2069@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010911131238.N715@athlon.random> you wrote:
> many thanks. At the moment my biggest concern is about the need of
> call_rcu not to be starved by RT threads (keventd can be starved so then
> it won't matter if krcud is RT because we won't start using it).

> Andrea

I think we can avoid keventd altogether by using a periodic timer (say 10ms)
to check for completion of an RC update. The timer may be active
only if only if there is any RCU going on in the system - that way
we still don't have any impact on the rest of the kernel.

I am working on such a thing - but it will take me a little bit
of time to figure out how to do this in linux.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
