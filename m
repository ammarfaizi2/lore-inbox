Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVETFNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVETFNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 01:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVETFNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 01:13:42 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:36226 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261336AbVETFNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 01:13:34 -0400
Message-ID: <428D71F9.10503@yahoo.com.au>
Date: Fri, 20 May 2005 15:13:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: chen Shang <shangcs@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
References: <855e4e4605051909561f47351@mail.gmail.com>	 <428D58E6.8050001@yahoo.com.au> <855e4e460505192117155577e@mail.gmail.com>
In-Reply-To: <855e4e460505192117155577e@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chen Shang wrote:

>>Hi Chen,
>>With the added branch and the extra icache footprint, it isn't clear
>>that this would be a win.
>>
>>Also, you didn't say where your statistics came from (what workload).
>>
>>So you really need to start by demonstrating some increase on some workload.
>>
>>Also, minor comments on the patch: please work against mm kernels,
>>please follow
>>kernel coding style, and don't change schedstat output format in the
>>same patch
>>(makes it easier for those with schedstat parsing tools).
>>
>>
>Hi Nick,
>
>Thank you very much for your comments. This is the first time of my
>kernel hacking. I will reduce the lines of changes as much as
>possible. As regard to the statistics, there are just count, ie, the
>total number of priority-recalculations vs. the number of priority
>changed from the former recalculation.
>
>

The only problem there is that changing the format will break
at least my schedstats parser.

Seeing as it is not some functional change to the scheduler,
your patch should not change schedstats. If you are *also*
interested in the priority changed vs unchanged statistic, then
you can do a patch for that seperately (ie. it doesn't depend
on your optimisation in question).

Thanks,
Nick


