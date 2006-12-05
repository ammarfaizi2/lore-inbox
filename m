Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030822AbWLET7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbWLET7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030843AbWLET7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:59:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54646 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030822AbWLET7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:59:41 -0500
Date: Tue, 5 Dec 2006 11:59:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@csn.ul.ie>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, apw@shadowen.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061205102654.19165150.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612051155190.18687@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie> <20061204143435.6ab587db.akpm@osdl.org>
 <Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
 <20061205101629.5cb78828.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0612050952500.11807@skynet.skynet.ie>
 <Pine.LNX.4.64.0612050803000.11213@schroedinger.engr.sgi.com>
 <20061205102654.19165150.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Andrew Morton wrote:

> On Tue, 5 Dec 2006 08:05:16 -0800 (PST)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > On Tue, 5 Dec 2006, Mel Gorman wrote:
> > 
> > > That is one possibility. There are people working on fake nodes for containers
> > > at the moment. If that pans out, the infrastructure would be available to
> > > create one node per DIMM.
> > 
> > Right that is a hack in use for one project.
> 
> Other projects can use it too.  It has the distinct advantage that it works
> with today's VM.

I'd be glad to make NUMA the default config. That allows us to completely 
get rid of zones. Just keep nodes around. Then we have a DMA node and a 
DMA32 node (working like a headless memory node) and a highmem node.

This would simplify the VM. But please do not have multiple nodes and 
multiple zones. If we do not like the term nodes then lets call them 
zones and get rid of the nodes.
