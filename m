Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbTACVrs>; Fri, 3 Jan 2003 16:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267694AbTACVri>; Fri, 3 Jan 2003 16:47:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:63451 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267683AbTACVqg>; Fri, 3 Jan 2003 16:46:36 -0500
Date: Fri, 03 Jan 2003 13:47:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ron cooper <rcooper@jamesconeyisland.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
Message-ID: <26860000.1041630449@flay>
In-Reply-To: <200301031549.29549.rcooper@jamesconeyisland.com>
References: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com> <14000000.1041617118@flay> <200301031549.29549.rcooper@jamesconeyisland.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Dual what Xeon? I presume a P4 thing. Can you cat /proc/interrupts?
>> Are you using the irq_balance code? If so, I think you'll only use
>> 1 cpu to process all the interrupts from each gigabit card. Not that
>> you have much choice, since Intel broke the P4's interrupt routing.
> 
> You got my attention with this statement.  I've have Dual Xeon Prestonias on 
> an I860 chipset (IWill dp400).  cat  /proc/interrupts indeed shows CPU0 as 
> processing all IRQ's instead of sharing them with CPU1 on a 2.4.x kernel.
> 
> Is there a work around for this, or is this *really* a problem?  Some say it 
> might be a problem depending on how many interrupts need to be processed per 
> second.  Others imply that cpu0 catching  the irq's might be a good thing.

Right - depends what you're doing. You can look at irq balance (in 2.5 
or 2.4-ac), but I don't like it as a solution much. Or you could try 
programming the TPR (were some patches floating around). Would be interesting
to get some perf measurments against people using the TPR patches (is more
expensive to set on a P4). Or someone from Intel posted some code recently
that seemed to do more intelligent things, but I haven't had the time to
look closely. If you want to experiment with that, I'm sure people would
be interested in the results.
 
> I happen to have PIII's using VIA chipsets that dont have this issue with 
> proc/interrupts.  This is very annonying, but I wonder if it is worth 
> worrying about.

P3's aren't as brain damaged.

M.

