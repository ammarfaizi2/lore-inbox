Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTLPXXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTLPXXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:23:39 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:22153 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264372AbTLPXXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:23:37 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide 
In-reply-to: Your message of "Mon, 15 Dec 2003 14:22:14 -0800."
             <20031215222213.GA1270@us.ibm.com> 
Date: Tue, 16 Dec 2003 17:32:37 +1100
Message-Id: <20031216232331.8A111189E1@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031215222213.GA1270@us.ibm.com> you write:
> > 	How do we get rid of read locks?  Getting rid of read locks
> > 	means that writers may be changing the list underneath the readers.
> > 	That is actually quite simple:
> 
> Looks good!  Upon rereading...  Does "wmb()" want to be "smp_wmb()"?

Yes, but I didn't want to turn this into a document on memory
barriers: you'll note that I almost avoided it entirely.

> Again, upon rereading, "read Read Copy Update code" probably wants to
> be "real Read Copy Update code".   I moused it this time, given
> my past record with eyeballing.  ;-)

Fixed.

> > Now, because the 'read lock' in RCU is simply disabling preemption, a
> > caller which always preemption disabled between calling
>                       disables preemption

Ah, I inserted a 'has' as well (a caller which always has preemption
disabled...).  The implication that the caller probably has preempt
disabled as a side effect of being in an interrupt or holding a
spinlock.

> > I've uploaded a new draft with these and other fixes...
> 
> Good stuff, thank you!!!

Hey, thanks for the review!

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
