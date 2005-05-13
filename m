Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVEMGbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVEMGbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVEMGbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:31:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42151 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262260AbVEMGbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:31:11 -0400
Date: Fri, 13 May 2005 12:01:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: george@mvista.com, Jesse Barnes <jesse.barnes@intel.com>,
       Tony Lindgren <tony@atomide.com>, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050513063113.GF23705@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <200505121435.01011.jesse.barnes@intel.com> <4283D581.9070008@mvista.com> <200505121743.46313.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505121743.46313.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 05:43:46PM -0700, Jesse Barnes wrote:
> But in this case you probably want it to, so it can rebalance tasks to 
> the CPU that just woke up.

Usually the sleeping idle CPU is sent a resched IPI, which will cause it to
call schedule or idle_balance_retry/rebalance_tick (ref: my earlier patch) to 
find out if it has do a load balance.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
