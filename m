Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVHOQZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVHOQZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVHOQZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:25:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21652 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964825AbVHOQZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:25:46 -0400
Date: Mon, 15 Aug 2005 21:17:26 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Tony Lindgren <tony@atomide.com>, tuukka.tikkanen@elektrobit.com,
       Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
       linux-kernel Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, george@mvista.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050815154726.GB4731@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050812201946.GA5327@in.ibm.com> <200508140053.21056.kernel@kolivas.org> <20050813164618.GA4659@in.ibm.com> <200508141018.29668.kernel@kolivas.org> <6189ECD1-1CE7-4E36-B9F4-FD4D9E5871FA@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6189ECD1-1CE7-4E36-B9F4-FD4D9E5871FA@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 12:15:38AM -0400, Kyle Moffett wrote:
> It may be a good idea to rebase this patch off the new generic time- 
> keeping
> subsystem that John Stultz is working on.

I _am_ using the new subsystem interface (->mark_offset) to catch up with lost
ticks. Only I don't think it is that good at catching up the lost ticks if we
skip ticks for few seconds in a stretch. For ex: I am observing drift (time
slows down) when skipping ticks for upto 5 seconds on a 699MHz P3 SMP hardware.
Both TSC and ACPI pm timer give this drift. I am investigating this and will
post an update as soon as I get more information.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
