Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbQKHQqM>; Wed, 8 Nov 2000 11:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129248AbQKHQqC>; Wed, 8 Nov 2000 11:46:02 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:6407 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129193AbQKHQp5>;
	Wed, 8 Nov 2000 11:45:57 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011081645.TAA17955@ms2.inr.ac.ru>
Subject: Re: [patch] NE2000
To: morton@nortelnetworks.com (Andrew Morton)
Date: Wed, 8 Nov 2000 19:45:26 +0300 (MSK)
Cc: andrewm@uow.edu.au, linux-kernel@vger.kernel.org
In-Reply-To: <3A07319B.7E2BD403@asiapacificm01.nt.com> from "Andrew Morton" at Nov 6, 0 10:32:59 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > In any case, Andrew, where is the race, when we enter in sleeping state?
> > Wakeup is not lost, it is just not required when we are not going
> > to schedule and force task to running state.
> 
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	add_wait_queue(...);
> 	/* window here */
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	schedule();
> 
> If there's a wakeup by another CPU (or this CPU in an interrupt) in
> that window, current->state will get switched to TASK_RUNNING.
> 
> Then it's immediately overwritten and we go to sleep.  Lost wakeup.

Look into code yet. It looks sort of different. Again:

> > Wakeup is not lost, it is just not required when we are not going
> > to schedule and force task to running state.

So that it is right not depening on anything.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
