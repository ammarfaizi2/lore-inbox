Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbTAPRHE>; Thu, 16 Jan 2003 12:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTAPRHE>; Thu, 16 Jan 2003 12:07:04 -0500
Received: from hexagon.stack.nl ([131.155.140.144]:17932 "EHLO
	hexagon.stack.nl") by vger.kernel.org with ESMTP id <S267185AbTAPRHD>;
	Thu, 16 Jan 2003 12:07:03 -0500
Date: Thu, 16 Jan 2003 18:15:54 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Why does a thread not sleep ?
Message-ID: <20030116175941.U29316-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In a driver, in the bottom half of an interrupt handler, I use
set_task_state (task, TASK_INTERRUPTIBLE) to make a task sleeping.
Sometimes (about 50 % of the cases), the task wakes up immediately again,
even though no signals are sent to the task. I tried TASK_UNINTERRUPTIBLE
and TASK_STOPPED too, but the same thing happens.

Can it be the task state is returned to TASK_RUNNING again in some
situations by other code ? Should I use locking, even on uniprocessor
systems ? Can a modification of the task state get lost in some situations
? I know about SMP related issues, but this doesn't even work on UP
kernels.

In other words: I don't get it. Help would be appreciated.

Thanks,

Jos
