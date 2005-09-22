Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVIVUmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVIVUmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVIVUmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:42:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53671 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751162AbVIVUl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:41:59 -0400
Date: Thu, 22 Sep 2005 21:41:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linux-ia64@vger.kernel.org, ak@suse.de,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050922204155.GA5400@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org,
	linux-ia64@vger.kernel.org, ak@suse.de,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0475A8B6@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0475A8B6@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 01:37:46PM -0700, Luck, Tony wrote:
> >Conduct some maintenance of the swiotlb code:
> >
> >	-- Move the code from arch/ia64/lib to lib
> 
> I agree that this code needs to move up out of arch/ia64, it is messy
> that x86_64 needs to reach over and grab this from arch/ia64.
> 
> But is "lib" really the right place for it to move to?  Perhaps
> a more logical place might be "drivers/pci/swiotlb/" since this
> code is tightly coupled to pci?

It should just go away once the GFP_DMA32 code is merged.
