Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131399AbRA3BXZ>; Mon, 29 Jan 2001 20:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131952AbRA3BXP>; Mon, 29 Jan 2001 20:23:15 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:31221 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S131399AbRA3BW5>;
	Mon, 29 Jan 2001 20:22:57 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list 
In-Reply-To: Your message of "Tue, 30 Jan 2001 12:05:41 +1100."
Date: Tue, 30 Jan 2001 12:22:52 +1100
Message-Id: <E14NPVU-0005nZ-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <3A74451F.DA29FD17@uow.edu.au> you write:
> > 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> > 
> > A lot of the timer deletion races are hard to fix because of
> > the deadlock problem.

Double take: we *did* fix the problems with del_timer_sync().  We
should probably have renamed del_timer to del_time_async and make
everyone fix their code though.  The `text vanishing under timer in
module' problem is solved by the pending module cleanup for 2.5.

Rusty.
--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
