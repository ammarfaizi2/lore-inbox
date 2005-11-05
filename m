Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVKEAFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVKEAFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKEAFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:05:52 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:59497 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751170AbVKEAFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:05:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Tky5OYpYrgxZByJ555xb2xLjFyZnyFwajQeHVcsz63QUD+lGWetrvLcMpyM4jglrD+obzZdcxSV9KSlAj/y9M+yxcUlgvV7TALPicqP8OruoCsdrUDQII/VvkysxFtrAlGGKdDOMIPlaIe8+9knGQIWMGy1WDNnkDDWXLim7we8=  ;
Message-ID: <436BF7D3.1090200@yahoo.com.au>
Date: Sat, 05 Nov 2005 11:07:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Gregory Maxwell <gmaxwell@gmail.com>, Andy Nelson <andy@thermo.lanl.gov>,
       mingo@elte.hu, akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051104201248.GA14201@elte.hu> <20051104210418.BC56F184739@thermo.lanl.gov> <e692861c0511041331ge5dd1abq57b6c513540fa200@mail.gmail.com> <200511042343.27832.ak@suse.de>
In-Reply-To: <200511042343.27832.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 04 November 2005 22:31, Gregory Maxwell wrote:
> 
>>
>>Thats the idea. The 'hugetlb zone' will only be usable for allocations
>>which are guaranteed reclaimable.  Reclaimable includes userspace
>>usage (since at worst an in use userspace page can be swapped out then
>>paged back into another physical location).
> 
> 
> I don't like it very much. You have two choices if a workload runs
> out of the kernel allocatable pages. Either you spill into the reclaimable
> zone or you fail the allocation. The first means that the huge pages
> thing is unreliable, the second would mean that all the many problems
> of limited lowmem would be back.
> 

These are essentially the same problems that the frag patches face as
well.

> None of this is very attractive.
> 

Though it is simple and I expect it should actually do a really good
job for the non-kernel-intensive HPC group, and the highly tuned
database group.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
