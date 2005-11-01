Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVKAU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVKAU7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVKAU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:59:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:51123 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751186AbVKAU7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:59:14 -0500
Message-ID: <4367D71A.1030208@austin.ibm.com>
Date: Tue, 01 Nov 2005 14:59:06 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
In-Reply-To: <4366D469.2010202@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The patches have gone through a large number of revisions, have been
>> heavily tested and reviewed by a few people. The memory footprint of this
>> approach is smaller than introducing new zones. If the cache footprint,
>> increased branches and instructions were a problem, I would expect 
>> them to
>> show up in the aim9 benchmark or the benchmark that ran ghostscript
>> multiple times on a large file.
>>
> 
> I appreciate that a lot of work has gone into them. You must appreciate
> that they add a reasonable amount of complexity and a non-zero perormance
> cost to the page allocator.

The patches do ad a reasonable amount of complexity to the page allocator.  In 
my opinion that is the only downside of these patches, even though it is a big 
one.  What we need to decide as a community is if there is a less complex way to 
do this, and if there isn't a less complex way then is the benefit worth the 
increased complexity.

As to the non-zero performance cost, I think hard numbers should carry more 
weight than they have been given in this area.  Mel has posted hard numbers that 
say the patches are a wash with respect to performance.  I don't see any 
evidence to contradict those results.

>> The will need high order allocations if we want to provide HugeTLB pages
>> to userspace on-demand rather than reserving at boot-time. This is a
>> future problem, but it's one that is not worth tackling until the
>> fragmentation problem is fixed first.
>>
> 
> Sure. In what form, we haven't agreed. I vote zones! :)

I'd like to hear more details of how zones would be less complex while still 
solving the problem.  I just don't get it.
