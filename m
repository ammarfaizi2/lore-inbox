Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131790AbRA3BGJ>; Mon, 29 Jan 2001 20:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRA3BF7>; Mon, 29 Jan 2001 20:05:59 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:22005 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S131495AbRA3BFp>;
	Mon, 29 Jan 2001 20:05:45 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list 
In-Reply-To: Your message of "Mon, 29 Jan 2001 03:13:19 +1100."
             <3A74451F.DA29FD17@uow.edu.au> 
Date: Tue, 30 Jan 2001 12:05:41 +1100
Message-Id: <E14NPEr-0005LR-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A74451F.DA29FD17@uow.edu.au> you write:
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> 
> A lot of the timer deletion races are hard to fix because of
> the deadlock problem.

Hmmm...

	For 2.5, changing the timer interface to disallow mod_timer or
add_timer (equivalent) on self, and making the timerfn return num
jiffies to next run (0 = don't rerun) would solve this, right?
I don't see a maintainable way of solving this otherwise,

	Of course, kfree'ing the timer struct and returning non-zero
would be a *bug*...

Rusty.
--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
