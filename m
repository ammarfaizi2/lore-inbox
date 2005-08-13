Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVHMQrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVHMQrX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVHMQrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:47:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11712 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932197AbVHMQrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:47:22 -0400
Date: Sat, 13 Aug 2005 22:16:18 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       ak@muc.de, schwidefsky@de.ibm.com, george@mvista.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050813164618.GA4659@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050812201946.GA5327@in.ibm.com> <200508131651.08809.kernel@kolivas.org> <20050813113717.GB4550@in.ibm.com> <200508140053.21056.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508140053.21056.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 12:53:20AM +1000, Con Kolivas wrote:
> Indeed this fixes it on my P4 so that it does skip ticks. However presumably 
> due to the code change I am having the reverse behaviour from previously - it 
> pauses for ages when using PIT - worse so than previously in that if I dont 
> generate interrupts with my mouse or keyboard it just sits there 
> indefinitely. Having said that, it seems to work fine in APIC mode. 

Can you explain what you mean by "pauses for ages when using PIT"? Is it
while running pmstat? What command line options did you use? I think I ran it 
on my LapTop in PIT mode w/o any problems. One problem that I am seeing on a 
SMP machines is that time drifts. I am yet to investigate whether it is a 
problem with that machine or my patch. As I had mentioned before, time 
recovery is still a concern that I have. I dont think it was any better in the
old patch.

> Without any modifications yet (I won't touch the code while you're busy with 
> it), here is a rolled up patch of yours on top of mine for those wanting to 
> try all the code:
> 
> http://ck.kolivas.org/patches/dyn-ticks/2.6.13-rc6-dtck-2.patch

Thanks for consolidating all the patches and putting it up on your website! 
Makes it easier for me to send any further patches on top of the above one.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
