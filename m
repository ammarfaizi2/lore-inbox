Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWBJFBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWBJFBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWBJFBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:01:07 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:18556 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751099AbWBJFBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:01:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lzxcAfiZ1L9LCnAk64oBCB3P6kBCOVJ7uE14z7WgI2XKrdLhfnl6zKrlTXc8TyYpPlNDNCA3ySDCaokX0/FLwIUvRHIFwYmBPy4sugV0Bw1kQA7u9mRG0Yb0bO61aer1muGeyV4yWBYLzFNJJ55yGmSTBCTNC598OXyXWpF5k3Y=  ;
Message-ID: <43EC1E0E.6060702@yahoo.com.au>
Date: Fri, 10 Feb 2006 16:01:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kernel@kolivas.org, linux-mm@kvack.org, ck@vds.kolivas.org, pj@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
References: <200602101355.41421.kernel@kolivas.org>	<200602101449.59486.kernel@kolivas.org>	<43EC1164.4000605@yahoo.com.au>	<200602101514.40140.kernel@kolivas.org>	<20060209202507.26f66be0.akpm@osdl.org>	<43EC1A85.2000001@yahoo.com.au> <20060209205559.409c0290.akpm@osdl.org>
In-Reply-To: <20060209205559.409c0290.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Con Kolivas <kernel@kolivas.org> wrote:
>>>
>>>
>>>>Ok I see. We don't have a way to add to the tail of that list though?
>>>
>>>
>>>del_page_from_lru() + (new) add_page_to_inactive_list_tail().
>>>
>>>
>>>
>>>>Is that 
>>>>a worthwhile addition to this (ever growing) project? That would definitely 
>>>>have an impact on the other code if not all done within swap_prefetch.c.. 
>>>>which would also be quite a large open coded something.
>>>
>>>
>>>Do both of the above in a new function in swap.c.
>>>
>>
>>That'll require the caller to do lru locking.
>>
>>I'd add an lru_cache_add_tail, use it instead of the current lru_cache_add
>>that Con's got now, and just implement it in a simple manner, without
>>pagevecs.
> 
> 
> umm, that's what I said ;)
> 

You said del_page_from_lru(), which doesn't belong in a function
called lru_cache_add_tail.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
