Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTIBIEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbTIBIEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:04:45 -0400
Received: from dyn-ctb-203-221-73-133.webone.com.au ([203.221.73.133]:12294
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263599AbTIBIEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:04:43 -0400
Message-ID: <3F544F11.4010700@cyberone.com.au>
Date: Tue, 02 Sep 2003 18:04:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v10
References: <3F5044DC.10305@cyberone.com.au> <1806700000.1062361257@[10.10.2.4]> <1807550000.1062362498@[10.10.2.4]> <3F52A546.9020608@cyberone.com.au> <6860000.1062441073@[10.10.2.4]>
In-Reply-To: <6860000.1062441073@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>>>Kernbench: (make -j vmlinux, maximal tasks)
>>>>                             Elapsed      System        User         CPU
>>>>             2.6.0-test4       45.87      116.92      571.10     1499.00
>>>>      2.6.0-test4-nick10       46.91      114.03      584.16     1489.25
>>>>
>>>>
>>>Actually, now looks like you have significantly more idle time, so perhaps
>>>the cross-cpu (or cross-node) balancing isn't agressive enough:
>>>
>>>
>>Yeah, there is a patch for this in mm that is not in mine. It should
>>help both mine and mainline though...
>>
>
>Not convinced of that - mm performs worse than mainline for me.
>

Well, one of Con's patches caused a lot of idle time on volanomark.
The reason for the change was unclear. I guess either a fairness or
wakeup latency change (yes, it was a very scientific process, ahem).

Anyway, in the process of looking at the load balancing, we found
and fixed a problem (although it might now possibly over balance).
This did cure most of the idle problems.

So it could just be small changes causing things to go out of whack.
I will try to get better data after (if ever) the thing is working
nicely on the desktop.


