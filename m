Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTLGRYs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLGRYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:24:48 -0500
Received: from dp.samba.org ([66.70.73.150]:64233 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264457AbTLGRYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:24:47 -0500
Date: Mon, 8 Dec 2003 04:22:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <20031207172227.GC19412@krispykreme>
References: <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth> <392900000.1070737269@[10.10.2.4]> <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com> <Pine.LNX.4.58.0312071433300.28463@earth> <20031207163914.GB19412@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207163914.GB19412@krispykreme>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> - I tried the HT scheduler with NUMA enabled. Same machine, 4 core 8
> threads, each NUMA node has 2 cores, 4 threads. Its easy to end up in a sub
> optimal state:

I just managed to get it into the same state with NUMA disabled:

 Cpu0 :   0.3% user,   0.0% system,   0.0% nice,  99.7% idle,   0.0% IO-wait
 Cpu1 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
 Cpu2 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle,   0.0% IO-wait
 Cpu3 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait

 Cpu4 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
 Cpu5 : 100.0% user,   0.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
 Cpu6 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle,   0.0% IO-wait
 Cpu7 :   0.0% user,   0.0% system,   0.0% nice, 100.0% idle,   0.0% IO-wait

Anton
