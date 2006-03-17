Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752474AbWCQBJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbWCQBJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbWCQBJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:09:18 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:24927 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1752474AbWCQBJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:09:17 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
	<4419062C.6000803@yahoo.com.au>
	<Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
	<441A04D0.3060201@yahoo.com.au>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Mar 2006 17:09:15 -0800
In-Reply-To: <441A04D0.3060201@yahoo.com.au> (Nick Piggin's message of "Fri, 17 Mar 2006 11:37:36 +1100")
Message-ID: <aday7z9nah0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Mar 2006 01:09:15.0921 (UTC) FILETIME=[6903B810:01C6495F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Nick> But it doesn't look like dma_alloc_coherent is guaranteed to
    Nick> return memory allocated from the regular page allocator, nor
    Nick> even memory backed by a struct page.

    Nick> For example, I see one that returns kmalloc()ed memory. If
    Nick> the pages for the slab are already allocated then __GFP_COMP
    Nick> will not do anything there. i386 looks like it has a path
    Nick> that uses ioremap...

Ugh.  So is there a correct way to map DMA-able memory into userspace?

 - R.
