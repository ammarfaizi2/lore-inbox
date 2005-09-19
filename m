Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVISTks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVISTks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVISTks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:25992 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932609AbVISTkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:40:47 -0400
Date: Mon, 19 Sep 2005 21:40:45 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
Message-ID: <20050919194038.GB12810@verdi.suse.de>
References: <200509101120.19236.ak@suse.de> <Pine.LNX.4.62.0509101904070.20145@schroedinger.engr.sgi.com> <20050910235139.4a8865c2.akpm@osdl.org> <200509110911.22212.ak@suse.de> <Pine.LNX.4.62.0509190958470.25549@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509190958470.25549@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 10:11:20AM -0700, Christoph Lameter wrote:
> However, one still does not know which memory section (vma) is allocated 
> on which nodes. And this may be important since critical data may need to 

Maybe. Well sure of things could be maybe important. Or maybe not.
Doesn't seem like a particularly strong case to add a lot of ugly
code though.

> External memory policy management is a necessary feature for system 
> administration, batch process scheduling as well as for testing and 
> debugging a system.

I'm not convinced of this at all. Most of these things proposed so far
can be done much simpler with 90% of the functionality (e.g. just swapoff
per process for migration) , and I haven't seen a clear rationale except
for lots of maybes that the missing 10% are worth all the complexity
you seem to plan to add.

-Andi
