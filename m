Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030735AbWLEUCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbWLEUCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968668AbWLEUCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:02:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54717 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S968664AbWLEUCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:02:06 -0500
Date: Tue, 5 Dec 2006 12:01:57 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061205112541.2a4b7414.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612051159510.18687@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
 <20061204120611.4306024e.akpm@osdl.org> <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
 <20061204131959.bdeeee41.akpm@osdl.org> <Pine.LNX.4.64.0612041337520.851@schroedinger.engr.sgi.com>
 <20061204142259.3cdda664.akpm@osdl.org> <Pine.LNX.4.64.0612050754560.11213@schroedinger.engr.sgi.com>
 <20061205112541.2a4b7414.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Andrew Morton wrote:

> > We always run reclaim against the whole zone not against parts. Why 
> > would we start running reclaim against a portion of a zone?
> 
> Oh for gawd's sake.

Yes indeed. Another failure to answer a simple question.
 
> If you want to allocate a page from within the first 1/4 of a zone, and if
> all those pages are in use for something else then you'll need to run
> reclaim against the first 1/4 of that zone.  Or fail the allocation.  Or
> run reclaim against the entire zone.  The second two options are
> self-evidently dumb.

Why would one want to allocate from the 1/4th of a zone? (Are we still 
discussing Mel's antifrag scheme or what is this about?)


