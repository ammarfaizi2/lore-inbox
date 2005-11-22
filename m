Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVKVIBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVKVIBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVKVIBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:01:35 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:29276 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964818AbVKVIBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:01:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=eU11bF/QzhFFcxng8GPW/WE8NV8aHf98ZqA6zWm6zzMBMHQnjeRuzNL6glj9kUb4D1bbujNEhYIvQnPBAidduhjZKnOeA4sMLODaf6ISoAun9MZp0xZi78j2BtJg4L0HmPjUK82c7dITcHJVSgNkTFlzGYO6EeVBhMJHRGEraeo=  ;
Message-ID: <4382DF04.3000001@yahoo.com.au>
Date: Tue, 22 Nov 2005 20:04:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 9/12] mm: page_state opt
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>	<20051121124235.14370.92215.sendpatchset@didi.local0.net> <20051121235405.2b6ce561.akpm@osdl.org>
In-Reply-To: <20051121235405.2b6ce561.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>-#define mod_page_state_zone(zone, member, delta)				\
>> -	do {									\
>> -		unsigned offset;						\
>> -		if (is_highmem(zone))						\
>> -			offset = offsetof(struct page_state, member##_high);	\
>> -		else if (is_normal(zone))					\
>> -			offset = offsetof(struct page_state, member##_normal);	\
>> -		else								\
>> -			offset = offsetof(struct page_state, member##_dma);	\
>> -		__mod_page_state(offset, (delta));				\
>> -	} while (0)
> 
> 
> I suppose this needs updating to know about the dma32 zone.
> 

Ah I didn't realise DMA32 is in the tree now. I think you're right.

I'll rebase this patchset when such an update is made. If you'd like
I could look at doing said DMA32 update for you?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
