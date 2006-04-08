Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWDHBoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWDHBoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWDHBoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:44:32 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:12110 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964993AbWDHBoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:44:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VChrlzJI+dle83x4tYkh9sXGmsEeNx38WkICynPrm12tx/f7GhsAwJarnuxRLpyY1NUjRxojhwsf1aRyqa8zYKKyHWBxdoPk4fBfyd3DxWmD1lSekKkEFiz7FR8/KXX+TDrwuxW12VK2Sd5A2Ic1FezaUCmoFgsAU3lWLrOx+K4=  ;
Message-ID: <443710F7.3040201@yahoo.com.au>
Date: Sat, 08 Apr 2006 11:25:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: limit lowmem_reserve
References: <200604021401.13331.kernel@kolivas.org> <200604081015.44771.kernel@kolivas.org> <443709F1.90906@yahoo.com.au> <200604081101.06066.kernel@kolivas.org>
In-Reply-To: <200604081101.06066.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 08 April 2006 10:55, Nick Piggin wrote:
> 
>>Con Kolivas wrote:
>>
>>>On Friday 07 April 2006 22:40, Nick Piggin wrote:
>>>
>>>>How would zone_watermark_ok always fail though?
>>>
>>>Withdrew this patch a while back; ignore
>>
>>Well, whether or not that particular patch isa good idea, it
>>is definitely a bug if zone_watermark_ok could ever always
>>fail due to lowmem reserve and we should fix it.
> 
> 
> Ok. I think I presented enough information for why I thought zone_watermark_ok 
> would fail (for ZONE_DMA). With 16MB ZONE_DMA and a vmsplit of 3GB we have a 
> lowmem_reserve of 12MB. It's pretty hard to keep that much ZONE_DMA free, I 
> don't think I've ever seen that much free on my ZONE_DMA on an ordinary 
> desktop without any particular ZONE_DMA users. Changing the tunable can make 
> the lowmem_reserve larger than ZONE_DMA is on any vmsplit too as far as I 
> understand the ratio.
> 

Umm, for ZONE_DMA allocations, ZONE_DMA isn't a lower zone. So that
12MB protection should never come into it (unless it is buggy?).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
