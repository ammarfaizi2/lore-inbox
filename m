Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270600AbRHTJac>; Mon, 20 Aug 2001 05:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269849AbRHTJaX>; Mon, 20 Aug 2001 05:30:23 -0400
Received: from CPE-61-9-150-69.vic.bigpond.net.au ([61.9.150.69]:54532 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S270601AbRHTJaS>;
	Mon, 20 Aug 2001 05:30:18 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kfree safe in interrupt context? 
In-Reply-To: Your message of "Fri, 17 Aug 2001 21:14:06 CST."
             <20010817211406.A21326@hq2> 
Date: Sun, 19 Aug 2001 21:44:45 +1000
Message-Id: <E15YR0Y-0007fD-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010817211406.A21326@hq2> you write:
> Seems like calling kfree from interrupt context should
> be ok, but is it? 
> If it is safe, is this considered a good thing  or not?

Yes, and it logically has to be, as kmalloc(..., GFP_ATOMIC) is safe
from interrupt context.

The network code does this all the time, for example.

Hope that helps,
Rusty.
--
Premature optmztion is rt of all evl. --DK
