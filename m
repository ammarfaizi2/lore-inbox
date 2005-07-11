Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVGKQQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVGKQQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVGKQNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:13:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30461 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262134AbVGKQLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:11:18 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread, take 2
From: Daniel Walker <dwalker@mvista.com>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050711145552.GA1489@us.ibm.com>
References: <20050711145552.GA1489@us.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 09:11:12 -0700
Message-Id: <1121098272.7050.13.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The PREEMPT_RT description doesn't seem correct. According to your
"hard" definition, PREEMPT_RT can provably hit a hard deadline for
interrupt response. 


Daniel


On Mon, 2005-07-11 at 07:55 -0700, Paul E. McKenney wrote:


> 
> a.	Quality of service: "soft realtime", with timeframe of a few 10s
> 	of microseconds for task scheduling and interrupt-handler entry.
> 	System services providing I/O, networking, task creation, and
> 	VM manipulation can take much longer, though some subsystems
> 	(e.g., ALSA) have been reworked to obtain good latencies.
> 	Since spinlocks are replaced by blocking mutexes, the performance
> 	penalty can be significant (up to 40%) for some system calls,
> 	but user-mode execution runs at full speed.  There is likely to
> 	be some performance penalty exacted from RCU, but, with luck,
> 	this penalty will be minimal.
> 
> 	Kristian Benoit and Karim Yaghmour have run an impressive set of
> 	benchmarks comparing CONFIG_PREEMPT_RT with CONFIG_PREEMPT(?) and
> 	Ipipe, see the LKML threads starting with:
> 
> 	1. http://marc.theaimsgroup.com/?l=linux-kernel&m=111846495403131&w=2
> 	2. http://marc.theaimsgroup.com/?l=linux-kernel&m=111928813818151&w=2
> 	3. http://marc.theaimsgroup.com/?l=linux-kernel&m=112008491422956&w=2
> 	4. http://marc.theaimsgroup.com/?l=linux-kernel&m=112086443319815&w=2
> 
> 	This last run put CONFIG_PREEMPT_RT at about 70 microseconds
> 	interrupt-response-time latency.  The machine under test was a
> 	Dell PowerEdge SC420 with a P4 2.8GHz CPU and 256MB RAM running
> 	a UP build of Fedora Core 3.


