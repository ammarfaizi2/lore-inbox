Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRDQKVh>; Tue, 17 Apr 2001 06:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRDQKVT>; Tue, 17 Apr 2001 06:21:19 -0400
Received: from CPE-61-9-150-66.vic.bigpond.net.au ([61.9.150.66]:62218 "EHLO
	mozart") by vger.kernel.org with ESMTP id <S131158AbRDQKVM>;
	Tue, 17 Apr 2001 06:21:12 -0400
Message-Id: <m14mzxf-001PKeC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        lse-tech-admin@lists.sourceforge.net, nigel@nrg.org
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Sat, 07 Apr 2001 16:54:52 MST."
             <OF42269F5F.CDF56B0F-ON88256A27.0083566F@LocalDomain> 
Date: Wed, 11 Apr 2001 01:21:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <OF42269F5F.CDF56B0F-ON88256A27.0083566F@LocalDomain> you write:
> > Already preempted tasks.
> 
> But if you are suppressing preemption in all read-side critical sections,
> then wouldn't any already-preempted tasks be guaranteed to -not- be in
> a read-side critical section, and therefore be guaranteed to be unaffected
> by the update (in other words, wouldn't such tasks not need to be waited
> for)?

Ah, if you want to inc and dec all the time, yes.  But even if the
performance isn't hurt, it's unneccessary, and something else people
have to remember to do.

Simplicity is very nice.  And in the case of module unload, gives us
the ability to avoid the distinction between "am I calling into a
module?" and "is this fixed in the kernel?" at runtime.  A very good
thing 8)

Rusty.
--
Premature optmztion is rt of all evl. --DK
