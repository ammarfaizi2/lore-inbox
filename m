Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTCTOvH>; Thu, 20 Mar 2003 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbTCTOvH>; Thu, 20 Mar 2003 09:51:07 -0500
Received: from dial-ctb03146.webone.com.au ([210.9.243.146]:36873 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261486AbTCTOvF>;
	Thu, 20 Mar 2003 09:51:05 -0500
Message-ID: <3E79D7CF.2020406@cyberone.com.au>
Date: Fri, 21 Mar 2003 02:01:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@digeo.com>, Joel.Becker@oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2
References: <20030319232812.GJ2835@ca-server1.us.oracle.com> <20030319175726.59d08fba.akpm@digeo.com> <20030320003858.GM2835@ca-server1.us.oracle.com> <20030320080449.GL4990@suse.de> <20030320002050.44f13857.akpm@digeo.com> <20030320082947.GM4990@suse.de>
In-Reply-To: <20030320082947.GM4990@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Thu, Mar 20 2003, Andrew Morton wrote:
>
>>Jens Axboe <axboe@suse.de> wrote:
>>
>>>Besides, deadline is still the most solid choice.
>>>
>>Deadline will always be the best choice for OLTP workloads.  Or CFQ - it
>>should perform the same.
>>
>>All this workload does is seeks all over the disk doing teeny synchronous
>>I/O's.  It is the worst-case for AS.
>>
>>What we are trying to do at present is to make AS not _too_ bad for these
>>workloads so that people with mixed workloads or who are not familiar with
>>kernel arcanery don't accidentally end up with something which is
>>significantly slower than it should be.
>>
>>It is an interesting test case.
>>
>
>I understand that. A deadline run is still interesting if there are
>regressions from -mm2 to -mm3, for example. If deadline shows the same
>regression, it's likely not a newly introduced AS bug.
>
You are quite right of course, Jens. I did tell Joel not to worry
about the other schedulers for a while just while I was trying to
get AS even close to their performance. I thought it would take a
bit longer to get there. It appears to be now, so yes, deadline
runs will be nice.

