Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVDHGdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVDHGdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVDHGdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:33:15 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:61093 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262704AbVDHGdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:33:09 -0400
Message-ID: <4256259E.2080102@yahoo.com.au>
Date: Fri, 08 Apr 2005 16:33:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Ingo Molnar <mingo@elte.hu>, george@mvista.com,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
References: <20050407124629.GA17268@in.ibm.com> <20050407151024.GA6565@elte.hu> <20050408053405.GA5392@in.ibm.com>
In-Reply-To: <20050408053405.GA5392@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Thu, Apr 07, 2005 at 05:10:24PM +0200, Ingo Molnar wrote:
> 
>>Interaction with VST is not a big issue right now because this only matters 
>>on SMP boxes which is a rare (but not unprecedented) target for embedded 
>>platforms.  
> 
> 
> Well, I don't think VST is targetting just power management in embedded 
> platforms. Even (virtualized) servers will benefit from this patch, by
> making use of the (virtual) CPU resources more efficiently.
> 

I still think looking at just using the rebalance backoff would be
a good start.

What would be really nice is to measure the power draw on your favourite
SMP system with your current patches that *don't* schedule ticks to
service rebalancing.

Then measure again with the current rebalance backoff settings (which
will likely be not very good, because some intervals are constrained to
quite small values).

Then we can aim for something like 80-90% of the first (ie perfect)
efficiency rating.

-- 
SUSE Labs, Novell Inc.

