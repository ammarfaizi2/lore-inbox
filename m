Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQLMFY5>; Wed, 13 Dec 2000 00:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQLMFYr>; Wed, 13 Dec 2000 00:24:47 -0500
Received: from UX4.SP.CS.CMU.EDU ([128.2.198.104]:27154 "HELO
	ux4.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S129572AbQLMFYe>;
	Wed, 13 Dec 2000 00:24:34 -0500
Message-ID: <3A370086.A2488771@cs.cmu.edu>
Date: Tue, 12 Dec 2000 23:52:22 -0500
From: Sourav Ghosh <sourav@cs.cmu.edu>
Organization: Carnegie Mellon University
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-rk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wake_up and wait_event
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have two questions:

1. Is it ok to make a "wake_up_process()" call from an interrupt
handler?

In my work, there is a kernel thread that sleeps under "sleep_on()" and
wakes up by the "wake_up_process()" by an interrupt handler.

My system is crashing and I just wanna make sure if this is not a
problem..

2. For the macros  __wait_event() and __wait_event_interruptible(), it
seems to me that they can't be called from a kernel thread as they set
the task "current" as "TASK_UNINTERRUPTIBLE" due to which it gets
removed from the scheduler runqueue. So the scheduler never chooses that
task again even if the task gets set as "TASK_RUNNING" at the end of the
macro.

Is that correct? If so, how is it possible to add the task to the
runqueue again (other than defining another new macro or function) ?

Thanks,

--
Sourav



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
