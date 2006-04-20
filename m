Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWDTRdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWDTRdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWDTRdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:33:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:16869 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750790AbWDTRdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:33:51 -0400
Date: Thu, 20 Apr 2006 19:33:34 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-ID: <20060420173334.GD21660@wotan.suse.de>
References: <20060228202202.14172.60409.sendpatchset@linux.site> <20060228202212.14172.59536.sendpatchset@linux.site> <20060420172205.GC21659@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420172205.GC21659@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 06:22:05PM +0100, Christoph Hellwig wrote:
> On Thu, Apr 20, 2006 at 07:06:18PM +0200, Nick Piggin wrote:
> > Add a remap_vmalloc_range and get rid of as many remap_pfn_range and
> > vm_insert_page loops as possible.
> > 
> > remap_vmalloc_range can do a whole lot of nice range checking even
> > if the caller gets it wrong (which it looks like one or two do).
> 
> This looks very nice, thanks!

Thank you

> Although it might be better to split it
> into one patch to introduce remap_vmalloc_range and various patches to
> switch over one susbsyetm for merging purposes.

Sure, if anyone insists ;)

I tend to agree. I would tend to do it in just 2 patches
(1 for implementation, 1 for conversion) to make administrative
overheads smaller -- the conversions are small and very well
contained. Is there a good reason to split further?

Nick
