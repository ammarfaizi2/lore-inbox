Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758462AbWK0R3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758462AbWK0R3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758464AbWK0R3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:29:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42678 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1758462AbWK0R3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:29:30 -0500
Date: Mon, 27 Nov 2006 09:28:45 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Mel Gorman <mel@skynet.ie>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611271628260.18063@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0611270926270.1515@schroedinger.engr.sgi.com>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org> <20061124104422.GA23426@skynet.ie>
 <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611251058350.6991@woody.osdl.org>
 <Pine.LNX.4.64.0611260039070.27769@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611271628260.18063@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006, Mel Gorman wrote:

> Later, MOVABLE might be a constraint. For example, hotpluggable nodes may only
> allow MOVABLE allocations to be allocated.

Also, (a much more immediate need since we have memory hotplug already) if 
a zone has hotpluggable memory then MOVABLE/unmovable allocations need to 
be restricted to a portion of the zone. The plugin/plugout memory area of 
a zone will not be able to tolerate unmovable allocations.

