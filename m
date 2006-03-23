Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWCWAQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWCWAQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWCWAQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:16:00 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:12126 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964896AbWCWAP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:15:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=N7C9rbWvKmAtv+4BD26jr/BPOTBRPDiMKNm5UVO6K96aQkRSa0IGx/QJEs/1OrX+qGKmzhb2MrdPzVmmcqyE3RjGp83rbV6pk6nOz4dtyVN3bkZCUIw+8M548tlXkp2zeKwrSf7ABQbRimT4nIU6A+2bdtxjup7ymurYQ2N0l60=  ;
Message-ID: <4421E8BA.2010807@yahoo.com.au>
Date: Thu, 23 Mar 2006 11:15:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC PATCH 30/35] Add generic_page_range() function
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063805.741915000@sorel.sous-sol.org> <44213333.6030404@yahoo.com.au> <79fcd3fd1d13741c5d1cd3c6f5b326b9@cl.cam.ac.uk> <503082446ce33efbf163ad2af63bb0e1@cl.cam.ac.uk>
In-Reply-To: <503082446ce33efbf163ad2af63bb0e1@cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> 
> On 22 Mar 2006, at 14:33, Keir Fraser wrote:
> 
>> Okay, can you suggest a better one? That's the best I could come up 
>> with that wasn't long winded.
> 
> 
> How about apply_to_page_range()?
> 

That would be better.

>>
>>> secondly, I think you confuse our (confusing) terminology: the page
>>> that holds pte_ts is not the pte_page, the pte_page is the page that
>>> a pte points to
>>
>>
>> What should we call it? Essentially we want to be able to get the 
>> physical address of a PTE in some cases, and passing struct page 
>> pointer seemed the best way to be able to derive that. I can rename it 
>> to something else vaguely plausible if the only problem is the 
>> semantic clash with Linux's idiomatic use of pte_page.
> 
> 
> Looks like pmd_page is correct?
> 

Yes... although maybe you could just pass the 'pmd_t *'? That's
what a lot of the mm/memory.c code does.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
