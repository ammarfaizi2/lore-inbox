Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTKHAdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTKGWE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:04:59 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55463 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264421AbTKGPlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:41:20 -0500
Date: Fri, 7 Nov 2003 16:31:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Gross <mgross@linux.co.intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <Pine.LNX.4.56.0311071610320.29925@earth>
Message-ID: <Pine.LNX.4.56.0311071629580.30463@earth>
References: <Pine.LNX.4.44.0311070701370.1842-100000@home.osdl.org>
 <Pine.LNX.4.56.0311071610320.29925@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the 'is it running' check is 'task_curr(p)', which in this circumstance is
> equivalent to the following test:
> 
> 	per_cpu(runqueues, (cpu)).curr == p

btw., the 'is it running right now' test is a necessary thing as well - we
really dont want to flood CPUs with IPIs which just happen to have the
target task in their runqueue (but the task is not executing).

	Ingo
