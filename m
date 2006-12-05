Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968607AbWLES1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968607AbWLES1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968605AbWLES1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:27:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33914 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968607AbWLES1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:27:45 -0500
Date: Tue, 5 Dec 2006 10:26:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Mel Gorman <mel@csn.ul.ie>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, apw@shadowen.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
Message-Id: <20061205102654.19165150.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612050803000.11213@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie>
	<20061130173129.4ebccaa2.akpm@osdl.org>
	<Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
	<20061201110103.08d0cf3d.akpm@osdl.org>
	<20061204140747.GA21662@skynet.ie>
	<20061204113051.4e90b249.akpm@osdl.org>
	<Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie>
	<20061204143435.6ab587db.akpm@osdl.org>
	<Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
	<20061205101629.5cb78828.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0612050952500.11807@skynet.skynet.ie>
	<Pine.LNX.4.64.0612050803000.11213@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 08:05:16 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Tue, 5 Dec 2006, Mel Gorman wrote:
> 
> > That is one possibility. There are people working on fake nodes for containers
> > at the moment. If that pans out, the infrastructure would be available to
> > create one node per DIMM.
> 
> Right that is a hack in use for one project.

Other projects can use it too.  It has the distinct advantage that it works
with today's VM.

> We would be adding huge 
> amounts of VM overhead if we do a node per DIMM.

No we wouldn't.

> So a desktop system with two dimms is to be treated like a NUMA 
> system?

Could do that.  Or make them separate zones.

> Or how else do we deal with the multitude of load balancing 
> situations that the additional nodes will generate?

No such problems are known.
