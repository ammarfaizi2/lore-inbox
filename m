Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVKOIsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVKOIsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVKOIsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:48:23 -0500
Received: from verein.lst.de ([213.95.11.210]:44684 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751383AbVKOIsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:48:21 -0500
Date: Tue, 15 Nov 2005 09:48:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68knommu: enable_irq/disable_irq
Message-ID: <20051115084800.GA1542@lst.de>
References: <20051113074136.GA816@lst.de> <437993A8.8050702@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437993A8.8050702@snapgear.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 05:52:08PM +1000, Greg Ungerer wrote:
> Hi Christoph,
> 
> Christoph Hellwig wrote:
> >mach_enable_irq/mach_disable_irq are never actually set, so let's remove
> >them.
> >
> >Btw, is it really intentionally that enable_irq/disable_irq are no-ops on
> >m68knommu?
> 
> No, I think they should be implemented. It would clean up some driver
> irq ugliness in some of the m68knommu arch specific drivers.

Any chance you could investigate using the kernel/irq/ framework for
m68knommu?  It's one of the few architectures not using that code yet.

