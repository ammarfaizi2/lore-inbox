Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbTIFGzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 02:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbTIFGzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 02:55:55 -0400
Received: from dyn-ctb-203-221-72-243.webone.com.au ([203.221.72.243]:64772
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263094AbTIFGzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 02:55:53 -0400
Message-ID: <3F5984F0.20806@cyberone.com.au>
Date: Sat, 06 Sep 2003 16:55:44 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]> <3F5980CD.2040600@cyberone.com.au>
In-Reply-To: <3F5980CD.2040600@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Martin J. Bligh wrote:
>
>>
>> OK. So you renice it ... then your two cpu jobs exit, and you kick off
>> xmms. Every time you waggle a window, X will steal the cpu back from
>> xmms, and it'll stall, surely? That's what seemed to happen before.
>> I don't see how you can fix anything by doing static priority 
>> alterations
>> (eg nice), because the workload changes.
>>
>> I'm probably missing something ... feel free to slap me ;-)
>>
>
> OK well just as a rough idea of how mine works: worst case for
> xmms is that X is at its highest dynamic priority (and reniced).
> xmms will be at its highest dynamic prio, or maybe one or two
> below that.
>
> X will get to run for maybe 30ms first, then xmms is allowed 6ms.
> That is still 15% CPU. And X soon comes down in priority if it
> continues to use a lot of CPU.
>

Backboost is not very different from renicing. It is just and implicit
and much less controlled way of allowing unfairness. And that is not
very different from the interactivity stuff either.


