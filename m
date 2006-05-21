Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWEUQU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWEUQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWEUQU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 12:20:58 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:16868 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751512AbWEUQU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 12:20:57 -0400
Date: Sun, 21 May 2006 17:20:53 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       tony.luck@intel.com, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
In-Reply-To: <200605202327.19606.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0605211709530.16327@skynet.skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet>
 <20060508141151.26912.15976.sendpatchset@skynet> <20060520135922.129a481d.akpm@osdl.org>
 <200605202327.19606.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2006, Andi Kleen wrote:

>
>> Anyway.  From the implementation I can see what the code is doing.  But I
>> see no description of what it is _supposed_ to be doing.  (The process of
>> finding differences between these two things is known as "debugging").  I
>> could kludge things by setting MAX_ACTIVE_REGIONS to 1000000, but enough.
>> I look forward to the next version ;)
>
> Or we could just keep the working old code.
>
> Can somebody remind me what this patch kit was supposed to fix or 
> improve again?
>

The current code for discovering the zone sizes and holes is sometimes 
very hairy despite there being some similaries in each arch. This patch 
kit will eliminiate some of the uglier code and have one place where zones 
and holes can be sized. To me, that is a good idea once the bugs are 
rattled out.

On a related note, parts of the current zone-based anti-fragmentation 
implementation are an architecture-specific mess because changing how 
zones are sized is tricky with the current code. With this patch kit, 
sizing zones for easily reclaimable pages is relatively straight-forward.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
