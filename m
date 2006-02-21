Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161296AbWBUCt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbWBUCt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWBUCt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:49:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:25316 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161292AbWBUCt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:49:28 -0500
Date: Mon, 20 Feb 2006 20:47:10 -0600
From: Mark Maule <maule@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
Message-ID: <20060221024710.GB30226@sgi.com>
References: <20060214162337.GA16954@sgi.com> <20060220201713.GA4992@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220201713.GA4992@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:17:14PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 14, 2006 at 10:23:37AM -0600, Mark Maule wrote:
> > Export sn_pcidev_info_get.
> 
> Tony or Andrew please back this out again.  The only reason SGI wants this is
> to support their illegal graphics driver, and no core code uses it.
> 
> And Mark, please stop submitting such patches.

All I'm doing by exporting sn_pcidev_info_get is allowing a module to use
the SGI SN_PCIDEV_BUSSOFT() macro which will tell a driver which piece of
altix PCI hw its device is sitting behind (e.g. PCIIO_ASIC_TYPE_TIOCP et. al).

While I acknowledge that the gfx driver folks requested this, I don't
understand what is "illegal" about this export, or the driver which wants
to use it.  What am I missing here?

Mark
