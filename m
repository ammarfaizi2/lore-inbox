Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVIWScT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVIWScT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVIWScT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:32:19 -0400
Received: from mx1.actcom.co.il ([192.114.47.64]:37022 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S1751129AbVIWScR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:32:17 -0400
Date: Fri, 23 Sep 2005 21:31:45 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Christoph Hellwig <hch@infradead.org>, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, ak@suse.de,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050923183145.GK7243@granada.merseine.nu>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0475A8B6@scsmsx401.amr.corp.intel.com> <20050922204155.GA5400@infradead.org> <20050923182233.GB6576@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923182233.GB6576@tuxdriver.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 02:22:35PM -0400, John W. Linville wrote:

> > It should just go away once the GFP_DMA32 code is merged.
> 
> Is that the plan?  I suppose it makes sense.

What about the odd devices that can do less than 32 bit DMA masks on
platforms without IOMMU?
 
> So, move it to driver/pci/swiotlb.c?  Or just leave it where it is?

drivers/pci/swiotlb.c makes sense. Xen has its own swiotlb.c these
days, moving it to drivers/pci/ should make it slightly easier to use
the generic one.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

