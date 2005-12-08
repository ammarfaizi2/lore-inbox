Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVLHUEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVLHUEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVLHUEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:04:42 -0500
Received: from ns2.suse.de ([195.135.220.15]:50131 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932277AbVLHUEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:04:42 -0500
Date: Thu, 8 Dec 2005 21:04:40 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] Re: pcibus_to_node value when no pxm info is present for the pci bus
Message-ID: <20051208200440.GB15804@wotan.suse.de>
References: <20051207223414.GA4493@localhost.localdomain> <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com> <20051208193439.GB3776@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208193439.GB3776@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The question is, what should be the default pcibus_to_node if there is no
> > > pxm info? Answer seems like -1 -- in which case dma_alloc_pages and e1000
> > > driver has to be fixed.
> > 
> > Why would they have to be fixed?
> 
> alloc_pages_node (used  by dma_alloc_pages) does not seem to do the check 
> though.  I guess alloc_pages_node needs to be fixed then.

Or just fix the caller. I will do that and change the default to
return -1 instead of 0.

Thanks,
-Andi
