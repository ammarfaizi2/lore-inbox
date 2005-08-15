Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVHOQkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVHOQkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVHOQkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:40:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42701 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964840AbVHOQkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:40:17 -0400
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
From: john stultz <johnstul@us.ibm.com>
To: vatsa@in.ibm.com
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Con Kolivas <kernel@kolivas.org>,
       ck@vds.kolivas.org, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, george@mvista.com
In-Reply-To: <20050815154726.GB4731@in.ibm.com>
References: <20050812201946.GA5327@in.ibm.com>
	 <200508140053.21056.kernel@kolivas.org> <20050813164618.GA4659@in.ibm.com>
	 <200508141018.29668.kernel@kolivas.org>
	 <6189ECD1-1CE7-4E36-B9F4-FD4D9E5871FA@mac.com>
	 <20050815154726.GB4731@in.ibm.com>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 09:39:22 -0700
Message-Id: <1124123963.4722.9.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 21:17 +0530, Srivatsa Vaddagiri wrote:
> On Sun, Aug 14, 2005 at 12:15:38AM -0400, Kyle Moffett wrote:
> > It may be a good idea to rebase this patch off the new generic time- 
> > keeping
> > subsystem that John Stultz is working on.
> 
> I _am_ using the new subsystem interface (->mark_offset) to catch up with lost
> ticks. Only I don't think it is that good at catching up the lost ticks if we
> skip ticks for few seconds in a stretch. 

Hey Srivatsa, 

The timer_opts interface is the existing interface, my work replaces it
and separates timekeeping from the timer interrupt.

You can find a cumulative version of my patch here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/0982.html

thanks
-john


