Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTJTIMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTJTIMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:12:31 -0400
Received: from dyn-ctb-210-9-246-89.webone.com.au ([210.9.246.89]:46087 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262434AbTJTIMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:12:23 -0400
Message-ID: <3F9398DB.8030004@cyberone.com.au>
Date: Mon, 20 Oct 2003 18:12:11 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
References: <20031020003745.GA2794@rushmore>	<3F933BE7.5080700@cyberone.com.au> <20031019215259.7b1c7a01.akpm@osdl.org>
In-Reply-To: <20031019215259.7b1c7a01.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>
>>rwhron@earthlink.net wrote:
>>
>>
>>>There was about a 50% regression in jobs/minute in AIM7
>>>database workload on quad P3 Xeon.  The CPU time has not
>>>gone up, so the extra run time is coming from something
>>>else.  (I/O or I/O scheduler?)
>>>
>>>tiobench sequential reads has a significant regression too.
>>>
>>>Regression appears unrelated to filesystem type.
>>>
>>>dbench was not affected.
>>>
>>>The AIM7 was run on ext2.
>>>
>>>
>>Yeah I'd say its all due to the IO scheduler. There is a problem
>>I'm thinking about how to fix - its the likely cause of this too.
>>
>>
>
>What change do you think it was due to?
>
>

I was thinking: [PATCH] fix AS crappy performance

(It still doesn't work properly)

>It's rather strange that test6 is slow but test6-mm is not: generally the
>IO scheduler regressions enter -mm first ;)
>

But if test6-mm isn't slow then maybe it is due to something else

