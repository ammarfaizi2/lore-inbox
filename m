Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVEMGXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVEMGXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVEMGXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:23:38 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9350 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262257AbVEMGXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:23:30 -0400
Date: Fri, 13 May 2005 11:53:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: george@mvista.com, jdike@addtoit.com,
       Jesse Barnes <jesse.barnes@intel.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050513062330.GD23705@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050512171251.GA21656@in.ibm.com> <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 08:08:26PM +0200, Martin Schwidefsky wrote:
> I would prefer a solution where the busy CPU wakes up an idle CPU if the
> imbalance is too large. Any scheme that requires an idle CPU to poll at
> some intervals will have one of two problem: either the poll intervall
> is large then the imbalance will stay around for a long time, or the
> poll intervall is small then this will behave badly in a heavily
> virtualized environment with many images.

I guess all the discussions we are having boils down to this: what is the max
time one can afford to have an imbalanced system because of sleeping idle CPU
not participating in load balance? 10ms, 100ms, 1 sec or more?

Maybe the answer depends on how much imbalance it is that we are talking of
here. A high order of imbalance would mean that the sleeping idle CPUs have
to be woken up quickly, while a low order imbalance could mean that 
we can let it sleep longer.

>From all the discussions we have been having, I think a watchdog
implementation makes more sense. Nick/Ingo, what do you think
should be our final decision on this?



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
