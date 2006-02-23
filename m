Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWBWRTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWBWRTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWBWRTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:19:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43476 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751753AbWBWRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:19:24 -0500
Date: Thu, 23 Feb 2006 09:17:33 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Alok Kataria <alok.kataria@calsoftinc.com>, penberg@cs.helsinki.fi,
       clameter@engr.sgi.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
In-Reply-To: <20060223020957.478d4cc1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602230916030.1796@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
 <20060223020957.478d4cc1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Andrew Morton wrote:

> I'm very much hoping that it is not needed.  Would prefer to just toss the
> whole thing away.

Right.

> What's it supposed to do anyway?  Keep wholly-unused pages hanging about in
> each slab cache?  If so, it may well be a net loss - it'd be better to push
> those pages back into the page allocator so they can get reused for
> something else while they're possibly still in-cache.  Similarly, it's
> better to fall back to the page allocator for a new slab page because
> that's more likely to give us a cache-hot one.

There needs to be some convincing rationale for SLAB_NO_REAP plus the 
documentation should be updated to explain correctly what it does if we 
decide to keep SLAB_NO_REAP.

