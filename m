Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVIWVio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVIWVio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVIWVio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:38:44 -0400
Received: from palrel10.hp.com ([156.153.255.245]:55262 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750947AbVIWVin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:38:43 -0400
Date: Fri, 23 Sep 2005 14:38:51 -0700
From: Grant Grundler <iod00d@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, ak@suse.de,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050923213851.GA6242@esmail.cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com> <20050923185021.GC6576@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923185021.GC6576@tuxdriver.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 02:50:23PM -0400, John W. Linville wrote:
> On Fri, Sep 23, 2005 at 11:27:26AM -0700, Luck, Tony wrote:
> > >> It should just go away once the GFP_DMA32 code is merged.
> > >
> > >Is that the plan?  I suppose it makes sense.
> 
> > I don't have a good (or in fact any) understanding of the impact
> > of GFP_DMA32 on ia64.  People tell me it will all be good, but I'd
> > like to hear from someone running it.
>  
> All the patches I saw were for x86_64.  So, the impact on ia64 should
> be minimal... :-)

impact to arch/ia64 might be minimal. My understanding was
all the drivers that support 32-bit devices would need tweaks
to use GFP_DMA32 flag.  Is this still the plan?
	http://www.ussg.iu.edu/hypermail/linux/kernel/9901.3/0323.html

Most of what I've read in Andi's patch otherwise makes sense:
	http://lwn.net/Articles/152337/

But I didn't see Andi suggest that swiotlb should go completely away.

thanks,
grant
