Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVLYHJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVLYHJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 02:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVLYHJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 02:09:39 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:12966 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750802AbVLYHJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 02:09:38 -0500
Message-ID: <43AE45AF.3010907@bigpond.net.au>
Date: Sun, 25 Dec 2005 18:09:35 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.1.6 for  2.6.15-rc5 and 2.6.15-rc5-mm2
References: <439E6BA0.8020302@bigpond.net.au>
In-Reply-To: <439E6BA0.8020302@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 25 Dec 2005 07:09:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> This version features a major gutting of the SPA based schedulers to 
> reduce overhead.  The inclusion of the mechanisms for gathering and 
> displaying accrued scheduling statistics have been made a compile time 
> configurable option (default is exclusion) as they are not an integral 
> part of the scheduler and were mainly there to help with tuning.  In a 
> future version they will be removed completely.
> 
> Additionally, the mechanism for auto detection and preferential 
> treatment of media streamers in the spa_ws scheduler has been made a 
> compile time option (default is exclusion).  The reason for this is that 
> my testing shows that the performance of media streamers on spa_ws is 
> adequate without it.  This will also be removed in a future version 
> unless requested otherwise.
> 
> A patch for 2.6.15-rc5 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.6-for-2.6.15-rc5.patch?download> 

Applies cleanly to 2.6.15-rc7 so no new patch will be posted.

> 
> 
> and a patch for 2.6.15-rc5-mm2 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.6-for-2.6.15-rc5-mm2.patch?download> 
> 
> 
> Very Brief Documentation:
> 
> You can select a default scheduler at kernel build time.  If you wish to
> boot with a scheduler other than the default it can be selected at boot
> time by adding:
> 
> cpusched=<scheduler>
> 
> to the boot command line where <scheduler> is one of: ingosched,
> nicksched, staircase, spa_no_frills, spa_ws, spa_svr or zaphod.  If you
> don't change the default when you build the kernel the default scheduler
> will be ingosched (which is the normal scheduler).
> 
> The scheduler in force on a running system can be determined by the
> contents of:
> 
> /proc/scheduler
> 
> Control parameters for the scheduler can be read/set via files in:
> 
> /sys/cpusched/<scheduler>/
> 
> Peter


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
