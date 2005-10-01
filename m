Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVJACkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVJACkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 22:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVJACkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 22:40:00 -0400
Received: from mail.tmr.com ([64.65.253.246]:52121 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750715AbVJACj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 22:39:59 -0400
Message-ID: <433DF76C.9010400@tmr.com>
Date: Fri, 30 Sep 2005 22:41:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Paul.McKenney@us.ibm.com, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] CART - an advanced page replacement policy
References: <20050929180845.910895444@twins>  <433C4343.20205@tmr.com> <1128093992.14695.22.camel@twins>
In-Reply-To: <1128093992.14695.22.camel@twins>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:

>On Thu, 2005-09-29 at 15:40 -0400, Bill Davidsen wrote:
>  
>
>>Peter Zijlstra wrote:
>>    
>>
>>>Multiple memory zone CART implementation for Linux.
>>>An advanced page replacement policy.
>>>
>>>http://www.almaden.ibm.com/cs/people/dmodha/clockfast.pdf
>>>(IBM does hold patent rights to the base algorithm ARC)
>>>      
>>>
>>Peter, this is a large patch, perhaps you could describe what configs 
>>benefit, 
>>    
>>
>
>All those that use swap. Those that exploit the weak side of LRU more
>than others.
>
>CART is an adaptive algorithm that will act like LFU on one side and LRU
>on the other, capturing both behaviours. Therefore it is also scan
>proof, eg. 'use once' scans should not flush the full cache.
>
>Hence people with LFU friendly applications will see an improvement
>while those who have an LRU friendly application should see no decrease
>in swap performance.
>
>Non of the algorithms handle cyclic access very well, that is what patch
>5 tries to tackle.
>
>  
>
>>how much, 
>>    
>>
>
>In the cyclic case (n+a: a << n) I've seen speedups of over 300%. Other
>cases much less. However I've yet to encounter a case where it gives
>worse performance.
>
>I'm still constructing some corner case tests to give more hard numbers.
>
>  
>
>>and what the right to use status of the patent might 
>>be. 
>>    
>>
>
>AFAIK IBM allows Linux implementation of their patents.
>See: http://news.com.com/IBM+pledges+no+patent+attacks+against+Linux/2100-7344_3-5296787.html
>
>  
>
>>In other words, why would a reader of LKML put in this patch and try it?
>>The description of how it works is clear, but the problem solved isn't.
>>    
>>
>
>I hope to have answered these questions. If any questions still remain,
>please let me know.
>

Thanks, you have cleared up all of the issues which I felt were unclear.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

