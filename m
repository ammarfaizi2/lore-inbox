Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTIGIKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 04:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTIGIKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 04:10:30 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:28167
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263336AbTIGIK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 04:10:29 -0400
Message-ID: <3F5AE7ED.7010501@cyberone.com.au>
Date: Sun, 07 Sep 2003 18:10:21 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Johnny Yau <jyau_kernel_dev@hotmail.com>
CC: "'Robert Love'" <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000201c374c8$1124ee20$f40a0a0a@Aria> <3F5ABE90.2040003@cyberone.com.au> <Law10-OE296cRyiOYbp00008b23@hotmail.com>
In-Reply-To: <Law10-OE296cRyiOYbp00008b23@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Johnny Yau wrote:

>>Heh, your logic is entertaining. I don't know how you got from step 1
>>to step 3 ;)
>>
>
>LOL...I got a bit scatterbrained.  My basic argument is the fewer context
>switches while maintaining interactivity the better because it's less
>overhead and less cache thrashing.  If we don't care about the overhead and
>thrashing at all, then might as well be very aggressive with the scheduler
>and use uniform 1 ms timeslices in a RR fashion.  I've coded such a
>scheduler in an embedded systems context; response time is awesome, but I
>highly doubt it'd work for Linux workloads.
>

Even if context switches don't cost anything, you still want to have
priorities so cpu hogs can be preempted by other tasks in order to
quickly respond to IO events. You want interactive tasks to be able
to sometimes get more cpu than cpu hogs, etc. Scheduling latency is
only a part of it.


