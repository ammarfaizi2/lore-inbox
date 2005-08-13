Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVHMPGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVHMPGW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHMPGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 11:06:22 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:41351 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751309AbVHMPGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 11:06:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Date: Sun, 14 Aug 2005 00:53:20 +1000
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       ak@muc.de, schwidefsky@de.ibm.com, george@mvista.com
References: <20050812201946.GA5327@in.ibm.com> <200508131651.08809.kernel@kolivas.org> <20050813113717.GB4550@in.ibm.com>
In-Reply-To: <20050813113717.GB4550@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508140053.21056.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005 21:37, Srivatsa Vaddagiri wrote:
> On Sat, Aug 13, 2005 at 04:51:07PM +1000, Con Kolivas wrote:
> > I'm sorry to say this doesn't appear to skip any ticks on my single P4
> > with SMP/SMT enabled.
>
> Con,
> 	I had enabled skipping ticks only in default_idle routine. So if
> you have a different idle route (which I suspect is the case), it will not
> skip ticks (since dyn_tick_reprogram_timer will not be called).
> Can you try this patch?

Indeed this fixes it on my P4 so that it does skip ticks. However presumably 
due to the code change I am having the reverse behaviour from previously - it 
pauses for ages when using PIT - worse so than previously in that if I dont 
generate interrupts with my mouse or keyboard it just sits there 
indefinitely. Having said that, it seems to work fine in APIC mode. 

Without any modifications yet (I won't touch the code while you're busy with 
it), here is a rolled up patch of yours on top of mine for those wanting to 
try all the code:

http://ck.kolivas.org/patches/dyn-ticks/2.6.13-rc6-dtck-2.patch

Cheers,
Con
