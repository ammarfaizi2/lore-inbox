Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVHLAjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVHLAjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 20:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVHLAjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 20:39:32 -0400
Received: from fmr24.intel.com ([143.183.121.16]:48600 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751040AbVHLAjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 20:39:32 -0400
Date: Thu, 11 Aug 2005 17:39:18 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, steiner@sgi.com, dvhltc@us.ibm.com,
       mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't kick ALB in the presence of pinned task)
Message-ID: <20050811173917.B581@unix-os.sc.intel.com>
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com> <42F94A00.3070504@yahoo.com.au> <20050809190352.D1938@unix-os.sc.intel.com> <1123729750.5188.13.camel@npiggin-nld.site> <20050811111411.A581@unix-os.sc.intel.com> <42FBE410.9070809@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42FBE410.9070809@yahoo.com.au>; from nickpiggin@yahoo.com.au on Fri, Aug 12, 2005 at 09:49:36AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 09:49:36AM +1000, Nick Piggin wrote:
> Well, it is a departure from our current idea of balancing.

That idea is already changing from the first line of the patch. 
And the change is "allowing the load to grow upto the sched 
group's cpu_power"

> I would prefer to use my patch initially to fix the _bug_
> you found, then we can think about changing policy for
> power savings.

Second part of the patch is just a logical extension of the
first one.

> 
> Main things I'm worried about:
> 
> Idle time regressions that pop up any time we put
> restrictions on balancing.

We are talking about lightly loaded case anyway. We are not changing
the behavior of a heavily loaded system.

> 
> This can tend to unbalance memory controllers (eg. on POWER5,
> CMP Opteron) which can be a performance problem on those
> systems.

We will do that already with the first line in the patch. 

If we want to distribute uniformly among the memory controllers, 
cpu_power of the group should reflect it (shared resources bottle neck).

> Lastly, complexity in the calculation.

My first patch is a simple straight fwd one.

thanks,
suresh
