Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752310AbWAFACq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbWAFACq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWAFACe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:02:34 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:34181 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932297AbWAFACI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:02:08 -0500
Message-ID: <43BDB37D.1030601@bigpond.net.au>
Date: Fri, 06 Jan 2006 11:02:05 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>, Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client   on interactive
 response
References: <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net> <43BDA80C.4020009@bigpond.net.au> <200601061033.10001.kernel@kolivas.org>
In-Reply-To: <200601061033.10001.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 6 Jan 2006 00:02:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Fri, 6 Jan 2006 10:13 am, Peter Williams wrote:
> 
>>If the plugsched patches were included in -mm we could get wider testing
>>of alternative scheduling mechanisms.  But I think it will take a lot of
>>testing of the new schedulers to allay fears that they may introduce new
>>problems of their own.
> 
> 
> When I first generated plugsched and posted it to lkml for inclusion in -mm it 
> was blocked as having no chance of being included by both Ingo and Linus and 
> I doubt they've changed their position since then. As you're well aware this 
> is why I gave up working on it and let you maintain it since then. Obviously 
> I thought it was a useful feature or I wouldn't have worked on it.

I've put a lot of effort into reducing code duplication and reducing the 
size of the interface and making it completely orthogonal to load 
balancing so I'm hopeful (perhaps mistakenly) that this makes it more 
acceptable (at least in -mm).

My testing shows that there's no observable difference in performance 
between a stock kernel and plugsched with ingosched selected at the 
total system level (although micro benchmarking may show slight 
increases in individual operations).

Anyway, I'll just keep plugging away,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
