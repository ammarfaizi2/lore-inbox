Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933692AbWKWN2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933692AbWKWN2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933705AbWKWN2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:28:16 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:62136 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S933692AbWKWN2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:28:12 -0500
Date: Thu, 23 Nov 2006 13:28:11 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andre Noll <maan@systemlinux.org>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
In-Reply-To: <20061123130817.GJ27761@skl-net.de>
Message-ID: <Pine.LNX.4.64.0611231327140.22648@skynet.skynet.ie>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de>
 <20061122155233.GA30607@skynet.ie> <20061122174223.GE27761@skl-net.de>
 <20061123120141.GA20920@skynet.ie> <20061123130817.GJ27761@skl-net.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006, Andre Noll wrote:

> On 12:01, Mel Gorman wrote:
>
>>>> Andre, if the bug still exists for you, can you apply Andi's patch to
>>>> reduce the log size and the following patch please and post us the
>>>> output with loglevel=8 please? Thanks
>>>
>>> Done. Here's the output of dmesg with your and Andi's patch applied.
>>>
>>
>> ahhh, I believe I see the problem now. Please try out the following patch.
>
> [...]
>
>> This patch sorts the early_node_map in find_min_pfn_for_node(). It has
>> been boot tested on x86, x86_64, ppc64 and ia64.
>
> That did the trick, you're the man!
>

heh, I was also the problem. Thanks a lot for reporting and testing.


-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
