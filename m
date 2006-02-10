Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWBJFoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWBJFoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWBJFoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:44:00 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:47207 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751125AbWBJFn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:43:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wPoJL5OO00cXrnJZ3Ekajou6RAbBG8QQMISfzQMo2COsekdaw7cpsu/VuMo6JgFAPT/JVHPpXY+/VlAnGRRWzP0UOa7tSBSeOyFSKZqS6mgwB/IaB2Y29h+hFSpCoal/w1+XgUkbJmZkhaW5Oo7c/nugWjPYNUy4DH7do8gAVTE=  ;
Message-ID: <43EC281B.2030000@yahoo.com.au>
Date: Fri, 10 Feb 2006 16:43:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
References: <200602101355.41421.kernel@kolivas.org> <200602101626.12824.kernel@kolivas.org> <43EC2572.7010100@yahoo.com.au> <200602101637.57821.kernel@kolivas.org>
In-Reply-To: <200602101637.57821.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 10 February 2006 16:32, Nick Piggin wrote:
> 
>>Con Kolivas wrote:
>>
>>>Just so it's clear I understand, is this what you (both) had in mind?
>>>Inline so it's not built for !CONFIG_SWAP_PREFETCH
>>
>>Close...
> 
> 
>>>+inline void lru_cache_add_tail(struct page *page)
>>
>>Is this inline going to do what you intend?
> 
> 
> I don't care if it's actually inlined, but the subtleties of compilers is way 
> beyond me. All it positively achieves is silencing the unused function 
> warning so I had hoped it meant that function was not built. I tend to be 
> wrong though...
> 

I don't think it can because it is not used in the same file.
You'd have to put it into the header file.

Not sure why it silences the unused function warning. You didn't
replace a 'static' with the inline? I don't think there is any
other way the compiler can know the function isn't used externally.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
