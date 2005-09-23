Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVIWSWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVIWSWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVIWSWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:22:54 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:61961 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750844AbVIWSWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:22:53 -0400
Date: Fri, 23 Sep 2005 14:22:35 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Christoph Hellwig <hch@infradead.org>, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, ak@suse.de,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050923182233.GB6576@tuxdriver.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	discuss@x86-64.org, linux-ia64@vger.kernel.org, ak@suse.de,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0475A8B6@scsmsx401.amr.corp.intel.com> <20050922204155.GA5400@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922204155.GA5400@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 09:41:55PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 22, 2005 at 01:37:46PM -0700, Luck, Tony wrote:
> > >Conduct some maintenance of the swiotlb code:
> > >
> > >	-- Move the code from arch/ia64/lib to lib
> > 
> > I agree that this code needs to move up out of arch/ia64, it is messy
> > that x86_64 needs to reach over and grab this from arch/ia64.
> > 
> > But is "lib" really the right place for it to move to?  Perhaps
> > a more logical place might be "drivers/pci/swiotlb/" since this
> > code is tightly coupled to pci?
> 
> It should just go away once the GFP_DMA32 code is merged.

Is that the plan?  I suppose it makes sense.

So, move it to driver/pci/swiotlb.c?  Or just leave it where it is?

Either way, I'll redo the other patches to reflect the correct
location.

John
-- 
John W. Linville
linville@tuxdriver.com
