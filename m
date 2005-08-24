Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVHXQ2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVHXQ2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVHXQ2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:28:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34263 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751122AbVHXQ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:28:30 -0400
Date: Wed, 24 Aug 2005 17:31:34 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Roland Dreier <rolandd@cisco.com>
Cc: Al Viro <viro@www.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (11/43) Kconfig fix (infiniband and PCI)
Message-ID: <20050824163134.GK9322@parcelfarce.linux.theplanet.co.uk>
References: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk> <528xyr1f0c.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528xyr1f0c.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 09:22:27AM -0700, Roland Dreier wrote:
>     Al> infiniband uses PCI helpers all over the place (including the
>     Al> core parts) and won't build without PCI.
> 
> I don't think this is the right fix.  The only PCI helpers used in
> code that is enabled with CONFIG_PCI=n are pci_unmap_addr_set() and
> pci_unmap_addr().  And they're only used because no one has added
> dma_unmap_addr_set() and dma_unmap_addr() -- the core code is properly
> using the general dma_xxx API wherever possible.
> 
> There actually is non-PCI InfiniBand hardware coming, so we'll have to
> fix this properly at some point.

I'm all for it and removing BROKEN from Kconfig when fixes happen is
obviously not a problem at all ;-)
