Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVB0RCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVB0RCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVB0RCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:02:33 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55728 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261438AbVB0RCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:02:18 -0500
Subject: Re: sched_yield behavior
From: Lee Revell <rlrevell@joe-job.com>
To: Giovanni Tusa <gtusa@inwind.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00e901c51cbb$45b3cac0$65071897@gtusa>
References: <00e901c51cbb$45b3cac0$65071897@gtusa>
Content-Type: text/plain
Date: Sun, 27 Feb 2005 12:02:13 -0500
Message-Id: <1109523733.30866.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-27 at 11:58 +0100, Giovanni Tusa wrote:
> Hi all,
> I have a question about the sched_yield behavior of Linux O(1) scheduler,
> for RT tasks.
> By reading some documentation, I found that " ....real-time tasks are a
> special case, because
> when they want to explicitly yield the processor to other waiting processes,
> they are merely
> moved to the end of their priority list (and not inserted into the expired
> array, like conventional
> processes)."
> I have to implement an RT task with the highest priority in the system (it
> is also the only task within the
> priority list for such priority level). Moreover, it has to be a SCHED_FIFO
> task,  so that it can preempt
> SCHED_RR ones, because of its strong real-time requirements. However,
> sometimes it should relinquish the
> CPU, to give to other tasks a chance to run.
> Now, what happen if it gives up the CPU by means of the sched_yield() system
> call?
> If  I am not wrong, the scheduler will choose it again (it will be still the
> higher priority task, and the only of its priority list).
> I have to add an explicit sleep to effectively relinquish the CPU for some
> time, or the scheduler can deal with such a
> situation in another way?

What exactly are you trying to do?  I don't understand how the task
could have "strong real-time requirements" if it's CPU bound.  What is
the exact nature of the real time constraint?

Lee

