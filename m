Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWCTKPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWCTKPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWCTKPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:15:14 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:34465 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750788AbWCTKPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:15:13 -0500
Date: Mon, 20 Mar 2006 11:13:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] latency-tracing-v2.6.16
Message-ID: <20060320101307.GA15477@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've released the latency-tracer patch for v2.6.16:

   http://redhat.com/~mingo/latency-tracing-patches/latency-tracing-v2.6.16.patch

max scheduling latencies can be tracked via the enabling of 
CONFIG_WAKEUP_TIMING. Tracking can be started via the resetting of the 
max latency:

	echo 0 > /proc/sys/kernel/preempt_max_latency

if CONFIG_LATENCY_TRACE is enabled too then an execution trace will be 
automatically generated as well, accessible via /proc/latency_trace.

if CONFIG_DEBUG_STACKOVERFLOW is enabled too then the function tracer 
will also track the maximum stack-footprint observed in the system, on a 
per-function-call basis. New maximums are reported to the syslog 
immediately. (which can be quite verbose during bootup.)

(the latency-tracer has numerous other features as well, such as 
userspace-triggered kernel-tracing, irq-triggered tracing, max 
preempt-off or irq-off tracing, trace-to-console-via-early-printk for 
the debugging of early bootup crashes, print-trace-at-crash, and more.  
See past postings and the code for details.)

	Ingo
