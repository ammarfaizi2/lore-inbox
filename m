Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272750AbRILK7k>; Wed, 12 Sep 2001 06:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272749AbRILK73>; Wed, 12 Sep 2001 06:59:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52942 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272751AbRILK7T>;
	Wed, 12 Sep 2001 06:59:19 -0400
Date: Wed, 12 Sep 2001 16:34:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: rusty@rustcorp.com.au
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010912163426.A5979@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010912182440.3975719b.rusty@rustcorp.com.au> you wrote:
> On Mon, 10 Sep 2001 17:54:17 +0200
> Andrea Arcangeli <andrea@suse.de> wrote:
>> Only in 2.4.10pre7aa1: 00_rcu-1
>> 
>> 	wait_for_rcu and call_rcu implementation (from IBM). I did some
>> 	modifications with respect to the original version from IBM.
>> 	In particular I dropped the vmalloc_rcu/kmalloc_rcu, the
>> 	rcu_head must always be allocated in the data structures, it has
>> 	to be a field of a class, rather than hiding it in the allocation
>> 	and playing dirty and risky with casts on a bigger allocation.

> Hi Andrea, 

> 	Like the kernel threads approach, but AFAICT it won't work for the case of two CPUs running wait_for_rcu at the same time (on a 4-way or above).

The patch I submitted to Andrea had logic to make sure that
two CPUs don't execute wait_for_rcu() at the same time.
Somehow it seems to have got lost in Andrea's modifications.

I will look at that and submit a new patch to Andrea, if necessary.

As for wrappers, I am agnostic. However, I think sooner or later
people will start asking for them, if we go by our past experience.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
