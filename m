Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272389AbRH3SPA>; Thu, 30 Aug 2001 14:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272391AbRH3SOu>; Thu, 30 Aug 2001 14:14:50 -0400
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:41480 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S272389AbRH3SOe>; Thu, 30 Aug 2001 14:14:34 -0400
Message-ID: <3B8E8264.8090700@ixiacom.com>
Date: Thu, 30 Aug 2001 11:13:56 -0700
From: Bryan Rittmeyer <bryan@ixiacom.com>
Organization: Ixia
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: arp.c duplicate assignment of skb->dev ("cosmetic")
In-Reply-To: <200108301718.f7UHIWq19376@wildsau.idv-edu.uni-linz.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:

> hi,
> 
> this is rather cosmetical than functional, but in arp.c,
> in arp_send(), on line 489
> 
> 	skb->dev=dev;
> 
> is assigned. in line 563, still in the same routine, it is
> assigned again without skb or skb->dev being changed. so I guess
> this second assignment is not neccessary. I can't see where
> skb->dev is changed within the 80  lines. so, we could remove
> the second assignment.


Hi Herbert,

I also noticed this dupe a couple days ago and pointed it out to
the lkml and net code maintainers. Alexey Kuznetsov has
agreed, saying:

"Apparently, this is right. This happened ages ago when eliminating
second argument dev_queue_xmit()."

I assume a fix will be in the next major release.

Regards,

Bryan


-- 
Bryan Rittmeyer
mailto:bryan@ixiacom.com

