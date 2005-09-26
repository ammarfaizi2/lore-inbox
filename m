Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVIZHBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVIZHBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVIZHBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:1949 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932419AbVIZHBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:01:53 -0400
From: Andi Kleen <ak@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Date: Mon, 26 Sep 2005 09:01:48 +0200
User-Agent: KMail/1.8
Cc: "John W. Linville" <linville@tuxdriver.com>,
       "Christoph Hellwig" <hch@infradead.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linux-ia64@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509260901.48972.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 20:27, Luck, Tony wrote:
> >> It should just go away once the GFP_DMA32 code is merged.
> >
> >Is that the plan?  I suppose it makes sense.
> >
> >So, move it to driver/pci/swiotlb.c?  Or just leave it where it is?
> >
> >Either way, I'll redo the other patches to reflect the correct
> >location.
>
> I don't have a good (or in fact any) understanding of the impact
> of GFP_DMA32 on ia64.  People tell me it will all be good, but I'd
> like to hear from someone running it.

It shouldn't change anything for IA64. GFP_DMA32 just becomes
an alias for your GFP_DMA.  On advantage is that drivers can
be now source level compatible between x86-64 and ia64 
for this (although they should be really using pci_alloc_consistent()
instead) 

> If it is good, and if it is coming soon, then there is no point
> moving swiotlb.  But I don't know the answers to either of those
> questions.

swiotlb is still needed even with GFP_DMA32. Just move it.
2.6.15 won't have it also.

-Andi

