Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUGOTrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUGOTrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUGOTrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:47:00 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36104 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266314AbUGOTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:46:58 -0400
Message-ID: <40F6E504.1@techsource.com>
Date: Thu, 15 Jul 2004 16:11:48 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Dumb question about Voluntary Kernel Preemption Patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this before, but I didn't get a response.  Either people missed 
it or it wasn't worth responding to.  I'll give it one more try before I 
shut up about it...


I have a question about voluntary kernel preemption in general.
(Shouldn't we call this "cooperative multitasking"?)

There are two disadvantages to voluntary preemption.  One is that the
kernel thread my not sleep enough (high latency), and the other is that
the kernel thread may sleep too much (wasted CPU for context switch
overhead).  The advantage of using the timer interrupt instead is that
the preemption happens only as often as it needs to.

My question is this:  Do your reschedule points (might_sleep or whatever
you end up using) ALWAYS reschedule, or do they only reschedule after a
certain period of time (timer interrupt increments counter, and
reschedule point does nothing if it's too early)?


