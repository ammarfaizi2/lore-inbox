Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVKQWDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVKQWDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVKQWDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:03:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932256AbVKQWDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:03:52 -0500
Date: Thu, 17 Nov 2005 22:03:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>,
       "Shai Fultheim (shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping -K4
Message-ID: <20051117220348.GA9297@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Muli Ben-Yehuda <mulix@mulix.org>, Andi Kleen <ak@suse.de>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Ravikiran G Thirumalai <kiran@scalex86.org>, niv@us.ibm.com,
	Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
	Muli Ben-Yehuda <MULI@il.ibm.com>,
	"Shai Fultheim (shai@scalex86.org)" <shai@scalex86.org>
References: <20051117131622.GC11966@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117131622.GC11966@granada.merseine.nu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 03:16:22PM +0200, Muli Ben-Yehuda wrote:
> Hi Andi,
> 
> Here's the latest version of the dma_ops patch. The patch is against
> Linus's tree as of yesterday and applies cleanly to
> 2.6.15-rc1-git5. Tested on AMD64 and Intel EM64 (x366) with gart,
> swiotlb, nommu and iommu=off. Please apply...

Any chance you could move struct dma_mapping_ops to generic code and
implement the dma_ operations ontop of them in linux/dma-mapping.h if
the arch sets a WANT_DMA_MAPPING_OPS symbol?  This kind of switch is
duplicated in far too many architectures.

