Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTIBO6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 10:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbTIBO6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 10:58:54 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:2764 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263796AbTIBO6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 10:58:38 -0400
Date: Tue, 02 Sep 2003 07:57:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v10
Message-ID: <127320000.1062514664@[10.10.2.4]>
In-Reply-To: <3F544F11.4010700@cyberone.com.au>
References: <3F5044DC.10305@cyberone.com.au> <1806700000.1062361257@[10.10.2.4]> <1807550000.1062362498@[10.10.2.4]> <3F52A546.9020608@cyberone.com.au> <6860000.1062441073@[10.10.2.4]> <3F544F11.4010700@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not convinced of that - mm performs worse than mainline for me.
> 
> Well, one of Con's patches caused a lot of idle time on volanomark.
> The reason for the change was unclear. I guess either a fairness or
> wakeup latency change (yes, it was a very scientific process, ahem).
> 
> Anyway, in the process of looking at the load balancing, we found
> and fixed a problem (although it might now possibly over balance).
> This did cure most of the idle problems.
> 
> So it could just be small changes causing things to go out of whack.
> I will try to get better data after (if ever) the thing is working
> nicely on the desktop.

I think Con and I worked out that the degredations I was seeing 
(on kernbench and SDET) were due to (in his words) "my hacks throwing the 
cc cpu hogs onto the expired array more frequently".

M.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
>> Not convinced of that - mm performs worse than mainline for me.
> 
> Well, one of Con's patches caused a lot of idle time on volanomark.
> The reason for the change was unclear. I guess either a fairness or
> wakeup latency change (yes, it was a very scientific process, ahem).
> 
> Anyway, in the process of looking at the load balancing, we found
> and fixed a problem (although it might now possibly over balance).
> This did cure most of the idle problems.
> 
> So it could just be small changes causing things to go out of whack.
> I will try to get better data after (if ever) the thing is working
> nicely on the desktop.

I think Con and I worked out that the degredations I was seeing 
(on kernbench and SDET) were due to (in his words) "my hacks throwing the 
cc cpu hogs onto the expired array more frequently".

M.

