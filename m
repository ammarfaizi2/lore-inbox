Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265946AbUGMVcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUGMVcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUGMVcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:32:11 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:5394 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265946AbUGMV3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:29:09 -0400
Message-ID: <40F459D6.2060808@techsource.com>
Date: Tue, 13 Jul 2004 17:53:26 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu>
In-Reply-To: <20040709182638.GA11310@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

