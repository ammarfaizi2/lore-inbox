Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVB0K62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVB0K62 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 05:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVB0K62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 05:58:28 -0500
Received: from smtp1.libero.it ([193.70.192.51]:28565 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S261372AbVB0K6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 05:58:24 -0500
Message-ID: <00e901c51cbb$45b3cac0$65071897@gtusa>
From: "Giovanni Tusa" <gtusa@inwind.it>
To: <linux-kernel@vger.kernel.org>
Subject: sched_yield behavior
Date: Sun, 27 Feb 2005 11:58:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have a question about the sched_yield behavior of Linux O(1) scheduler,
for RT tasks.
By reading some documentation, I found that " ....real-time tasks are a
special case, because
when they want to explicitly yield the processor to other waiting processes,
they are merely
moved to the end of their priority list (and not inserted into the expired
array, like conventional
processes)."
I have to implement an RT task with the highest priority in the system (it
is also the only task within the
priority list for such priority level). Moreover, it has to be a SCHED_FIFO
task,  so that it can preempt
SCHED_RR ones, because of its strong real-time requirements. However,
sometimes it should relinquish the
CPU, to give to other tasks a chance to run.
Now, what happen if it gives up the CPU by means of the sched_yield() system
call?
If  I am not wrong, the scheduler will choose it again (it will be still the
higher priority task, and the only of its priority list).
I have to add an explicit sleep to effectively relinquish the CPU for some
time, or the scheduler can deal with such a
situation in another way?

Any advice will be appreciated.
Giovanni




