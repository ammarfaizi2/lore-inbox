Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVEMJTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVEMJTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 05:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVEMJTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 05:19:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26280 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262316AbVEMJTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 05:19:25 -0400
Date: Fri, 13 May 2005 14:49:24 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       george@mvista.com, jdike@addtoit.com,
       Jesse Barnes <jesse.barnes@intel.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050513091924.GG23705@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050512171251.GA21656@in.ibm.com> <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com> <20050513062330.GD23705@in.ibm.com> <42845456.3080908@yahoo.com.au> <20050513080424.GA31206@elte.hu> <428464D5.10702@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428464D5.10702@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 08:29:17AM +0000, Nick Piggin wrote:
> And don't forget that the watchdog approach can just as easily deep
> sleep a CPU only to immediately wake it up again if it detects an
> imbalance.

I think we should increase the threshold beyond which the idle CPU
is woken up (more than the imbalance_pct that exists already). This
should justify waking up the CPU.

> And the CPU usage / wakeup cost arguments cut both ways. The busy
> CPUs have to do extra work in the watchdog case.

Maybe with a really smart watchdog solution, we can cut down this overhead.
I did think of other schemes - a dedicated CPU per node acting as watchdog 
for that node and per-node wacthdog kernel threads? - to name a few. What I had
proposed was the best I thought. But maybe we can look at improving it 
to see if the overhead concern you have can be reduced - meeting the interests
of both the worlds :)


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
