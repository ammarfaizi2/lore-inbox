Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269879AbUH0An0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269879AbUH0An0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269854AbUH0Ajl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:39:41 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18886 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269794AbUH0Ag5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:36:57 -0400
Date: Fri, 27 Aug 2004 09:42:05 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap [3/4]
In-reply-to: <1093565707.2984.394.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
Message-id: <412E835D.8080500@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <412DD34A.70802@jp.fujitsu.com>
 <1093535709.2984.24.camel@nighthawk> <412E7AB6.8020707@jp.fujitsu.com>
 <1093565707.2984.394.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
>>1. Now, I think some small parts, some essence of mem_section which
>>   makes pfn_valid() faster may be good.
> 
> 
> The only question is what it will take when there's a partially populate
> mem_section.  We'll almost certainly have to allow it, but the real
> question is whether or not we will ever have a partially populated one
> that's not at the end of memory.  
> 
Hmm....I cannot answer it fully.

My tiger4 (Itanium x 2) shows aligned_order=0, because it has a mem_map
start with address 0x????????3(I forget now), odd number ;(.
I like a mechine in which all memory are aligned.....

>>And another way,
>>
>>2. A method which enables page -> page's max_order calculation
>>   may be good and consistent way in this no-bitmap approach.
>>
>>But this problem would be my week-end homework :).
> 
> 
> Instead of adding more stuff to the mem_section, we might be able to
> (ab)use more stuff in the mem_map's mem_map, like I am with
> page->section right now.  

I wonder if there is another way which doesn't increase memory usage
in boottime, it will be better.
I'll going on considering the way to fix nr_mem_map things.

Thanks
-- Kame


-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

