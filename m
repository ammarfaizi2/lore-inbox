Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFOEBd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 00:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTFOEBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 00:01:30 -0400
Received: from dyn-ctb-210-9-243-172.webone.com.au ([210.9.243.172]:49668 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261843AbTFOEB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 00:01:29 -0400
Message-ID: <3EEBF2C1.4050101@cyberone.com.au>
Date: Sun, 15 Jun 2003 14:14:57 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Mingming Cao <cmm@us.ibm.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm9
References: <20030613013337.1a6789d9.akpm@digeo.com>	<3EEAD41B.2090709@us.ibm.com>  <20030614010139.2f0f1348.akpm@digeo.com> <1055637690.1396.15.camel@w-ming2.beaverton.ibm.com>
In-Reply-To: <1055637690.1396.15.camel@w-ming2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mingming Cao wrote:

>On Sat, 2003-06-14 at 01:01, Andrew Morton wrote:
>
>
>>Was elevator=deadline observed to fail in earlier kernels?  If not then it
>>may be an anticipatory scheduler bug.  It certainly had all the appearances
>>of that.
>>
>Yes, with elevator=deadline the many fsx tests failed on 2.5.70-mm5.
> 
>
>>So once you're really sure that elevator=deadline isn't going to fail,
>>could you please test elevator=as?
>>
>>
>Ok, the deadline test was run for 10 hours then I stopped it (for the
>elevator=as test).  
>
>But the test on elevator=as (2.5.70-mm9 kernel) still failed, same
>problem.  Some fsx tests are sleeping on io_schedule().  
>

So by failed, you just mean stuck in io_schedule? Are you sure
they are permanently stuck there? Is any progress being made?
I have tried this test, and often some or most of the processes
wait in io_schedule for a while, but do get woken.



