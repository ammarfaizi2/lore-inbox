Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbVKBIlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbVKBIlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVKBIlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:41:46 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:58755 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932657AbVKBIlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:41:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CZ9yBOtNuiLW2n4yUK3dyYs4A4Tnnhd5pf7+nIyL/2FUsHFzPy2qlkfBeMkITd8YfMoxrFpAyTfaGvnUa8rM/SfxAxewpz4p83ACLTl2o7o9RnMKOiUSlhOCE5M8LYxiF1lfLQ9MopDOWcNzfbU1HtDHvkF/ob+bmExHsdCpANY=  ;
Message-ID: <43687C3D.7060706@yahoo.com.au>
Date: Wed, 02 Nov 2005 19:43:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <1130917338.14475.133.camel@localhost> <436877DB.7020808@yahoo.com.au> <20051102172729.9E7C.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20051102172729.9E7C.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto wrote:
>>>One other thing, if we decide to take the zones approach, it would have
>>>no other side benefits for the kernel.  It would be for hotplug only and
>>>I don't think even the large page users would get much benefit.  
>>>
>>
>>Hugepage users? They can be satisfied with ZONE_REMOVABLE too. If you're
>>talking about other higher-order users, I still think we can't guarantee
>>past about order 1 or 2 with Mel's patch and they simply need to have
>>some other ways to do things.
> 
> 
> Hmmm. I don't see at this point.
> Why do you think ZONE_REMOVABLE can satisfy for hugepage.
> At leaset, my ZONE_REMOVABLE patch doesn't any concern about
> fragmentation.
> 

Well I think it can satisfy hugepage allocations simply because
we can be reasonably sure of being able to free contiguous regions.
Of course it will be memory no longer easily reclaimable, same as
the case for the frag patches. Nor would be name ZONE_REMOVABLE any
longer be the most appropriate!

But my point is, the basic mechanism is there and is workable.
Hugepages and memory unplug are the two main reasons for IBM to be
pushing this AFAIKS.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
