Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTFFW3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTFFW3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:29:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4775 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262328AbTFFW3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:29:07 -0400
Message-ID: <3EE117CF.9060106@austin.ibm.com>
Date: Fri, 06 Jun 2003 17:38:07 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Nightly regression run results
References: <3EDF6F49.8070201@austin.ibm.com> <3EDFEFBB.7080507@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Yes, the read tests do currently run primarily out of cache. This does 
have some value for measuring the relative overhead of the i/o apis. To 
avoid cache effects, and measure the real throughput, we need to bump 
the size up and, as you suggest, size*2 is a good value to use. We've 
tried to keep the overall test suite time down by maintaining shorter 
runs whereever possible. So rather than increasing to run size by 2, we 
will reduce the memory used, at boot, then use runs of newsmallsize*2. 
This will keep the runs from taking too long and also avoid the cache 
benefits. We will have to tweak this to come up with the appropriate 
balance of memsize vs run time. This should be available in a few days.

Thanks for the feedback.

Mark

Nick Piggin wrote:

>
>
> Mark Peloquin wrote:
>
>>
>>
>> Here are links to some 2.5.70 nightly regression comparisons:
>>
> It appears your tiobench reads are coming out of cache.
> Would you be able add some runs with the size >= 2*ram
> please? I don't know if anyone would still find the
> current type useful - maybe for scalability work?
>
> Thanks
> Nick



