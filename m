Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVKOJxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVKOJxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVKOJxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:53:31 -0500
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:28266 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751414AbVKOJxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:53:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3kzLWORsd7CXiIziolMYxMGrEvegz4C3AShtwfBwHH9tZYOOPgQ6XRKCev557XlhqJk2ziqoSxbggG9D+S3DrYI+fsY7KxXpMxVdBI/RGI8dHdPG8yyfb6LWkwbLUhREOqyXRleHMbfvRgYDnjf9gjVDFu5tmXwZu0Q5tAebyn8=  ;
Message-ID: <4379B0A7.3090803@yahoo.com.au>
Date: Tue, 15 Nov 2005 20:55:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pj@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Simon.Derr@bull.net, clameter@sgi.com, rohit.seth@intel.com
Subject: Re: [PATCH 03/05] mm rationalize __alloc_pages ALLOC_* flag names
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>	<20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>	<4379A399.1080407@yahoo.com.au> <20051115010303.6bc04222.akpm@osdl.org>
In-Reply-To: <20051115010303.6bc04222.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Paul Jackson wrote:
>>
>>>Rationalize mm/page_alloc.c:__alloc_pages() ALLOC flag names.
>>>
>>
>>I don't really see the need for this. The names aren't
>>clearly better, and the downside is that they move away
>>from the terminlogy we've been using in the page allocator
>>for the past few years.
> 
> 
> I thought they were heaps better, actually.
> 

Some? Alot? Musthave?

To me it just changed the manner in which the hands are waving.
Actually, I like the current names because ALLOC_HIGH explicitly
is used for __GFP_HIGH allocations, and MUSTHAVE is not really
an improvement on NO_WATERMARKS.

However if you'd really like to change the names, I'd prefer them
to be more consistent, eg:

ALLOC_DIP_NONE
ALLOC_DIP_LESS
ALLOC_DIP_MORE
ALLOC_DIP_FULL

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
