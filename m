Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVELIys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVELIys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVELIs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:48:26 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42179 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261350AbVELIqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:46:04 -0400
Date: Thu, 12 May 2005 14:16:50 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050512084650.GA20978@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <427D921F.8070602@yahoo.com.au> <20050511180349.GG15479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511180349.GG15479@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 11:03:49AM -0700, Tony Lindgren wrote:
> Sorry to jump in late. For embedded stuff we should be able to skip
> ticks until something _really_ happens, like an interrupt.
> 
> So we need to be able to skip ticks several seconds at a time. Ticks
> should be event driven. For embedded systems option B is really
> the only way to go to take advantage of the power savings.

I don't know how sensitive embedded platforms are to load imbalance.
If they are not sensitive, then we could let the max time idle
cpus are allowed to sleep to be few seconds. That way, idle CPU
wakes up once in 3 or 4 seconds to check for imbalance and still
be able to save power for those 3/4 seconds that it sleeps.

I guess it is a tradeoff here between the complexity we want to
put and the real benefit we get. Its hard for me to get the numbers
(since I don't have easy access to the right tools to measure them)
to show how much the real benefit is :(

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
