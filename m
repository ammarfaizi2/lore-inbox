Return-Path: <linux-kernel-owner+w=401wt.eu-S1751269AbWLLNOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWLLNOo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWLLNOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:14:44 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3038 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbWLLNOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:14:43 -0500
Message-ID: <457EAB38.2020506@shadowen.org>
Date: Tue, 12 Dec 2006 13:14:32 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-mm@kvack.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Lumpy Reclaim V3
References: <exportbomb.1165424343@pinky> <20061212031312.e4c91778.akpm@osdl.org>
In-Reply-To: <20061212031312.e4c91778.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 6 Dec 2006 16:59:04 +0000
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>> This is a repost of the lumpy reclaim patch set.
> 
> more...
> 
> One concern is that when the code goes to reclaim a lump and fails, we end
> up reclaiming a number of pages which we didn't really want to reclaim. 
> Regardless of the LRU status of those pages.
> 
> I think what we should do here is to add the appropriate vmstat counters
> for us to be able to assess the frequency of this occurring, then throw a
> spread of workloads at it.  If that work indicates that there's a problem
> then we should look at being a bit smarter about whether all the pages look
> to be reclaimable and if not, restore them all and give up.
> 
> Also, I suspect it would be cleaner and faster to pass the `active' flag
> into isolate_lru_pages(), rather than calculating it on the fly.  And I
> don't think we need to calculate it on every pass through the loop?
> 
> 
> We really do need those vmstat counters to let us see how effective this
> thing is being.  Basic success/fail stuff.  Per-zone, I guess.


Sounds like a cue ... I'll go do that.

-apw


