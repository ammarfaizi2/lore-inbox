Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTIQW54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTIQW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:57:56 -0400
Received: from dyn-ctb-203-221-73-126.webone.com.au ([203.221.73.126]:8452
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262898AbTIQW5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:57:54 -0400
Message-ID: <3F68E6D2.50204@cyberone.com.au>
Date: Thu, 18 Sep 2003 08:57:22 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Sullivan <mksully@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: I/O degredation with AS on 2.6.0-test3
References: <OF7EFA21A7.C5FDCD40-ON85256DA4.005356E3@us.ibm.com>
In-Reply-To: <OF7EFA21A7.C5FDCD40-ON85256DA4.005356E3@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Sullivan wrote:

>
>>>Dave Hansen wrote:
>>>
>>>You might want to try Martin Bligh's diffprofile utility.  It's a bit
>>>hard to compare 2 500-line profiles without it.
>>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/tools/
>>>
>>>Also, there have evidently been a few I/O scheduler fixes since -test3.
>>>Please retry with -test5.
>>>
>>>
>
>>Nick Piggen wrote:
>>More important, are they regressions vs. previous kernels with AS?
>>
>
>I've checked 2.5.69mm9, 2.5.75, 2.6.0test3, and 2.6.0test5 and they all
>show a
>significant degradation in IO performance (>40%) when using the as
>scheduler
>compared to the deadline scheduler.
>
>Configuration: IBM x440 8way with hypertheading enabled, 16GB RAM,
>4 QLA2310 FC adapters attached to 2 FastT900 controllers
>(112 disks total). The 112 physical disks are striped as 8 raid 0
>logical disks. There are a total of 40 raw devices setup (5 per raid0
>disk).
>
>I've reattached excerpts from the database test for vmstat and
>the readprofile diffs created from Martin's diffprofile utility
>(diffprofile readp.as readp.dl).
>

Thanks Mike, I'll get a patch for you to try soon. I'm a bit busy ATM.


