Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129577AbQKFSrT>; Mon, 6 Nov 2000 13:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbQKFSrJ>; Mon, 6 Nov 2000 13:47:09 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:40197 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129577AbQKFSqz>;
	Mon, 6 Nov 2000 13:46:55 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011061846.VAA20608@ms2.inr.ac.ru>
Subject: Re: [patch] NE2000
To: andrewm@uow.EDU.AU (Andrew Morton)
Date: Mon, 6 Nov 2000 21:46:34 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A039E77.5DD87DF0@uow.edu.au> from "Andrew Morton" at Nov 4, 0 08:45:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> No, that code is correct, provided (current->state == TASK_RUNNING)
> on entry.  If it isn't, there's a race window which can cause
> lost wakeups.   As a check you could add:
> 
> 	if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE)) == 0)
> 		BUG();

Though it really cannot happen and really happens, as we have seen... 8)

In any case, Andrew, where is the race, when we enter in sleeping state?
Wakeup is not lost, it is just not required when we are not going
to schedule and force task to running state.

I still do not see how it is possible that task runs in sleeping state.
Apparently, set_current_state is forgotten somewhere. Do you see, where? 8)

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
