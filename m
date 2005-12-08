Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVLHUVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVLHUVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLHUVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:21:49 -0500
Received: from serv01.siteground.net ([70.85.91.68]:39652 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932330AbVLHUVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:21:48 -0500
Date: Thu, 8 Dec 2005 12:21:38 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] Re: pcibus_to_node value when no pxm info is present for the pci bus
Message-ID: <20051208202138.GD3776@localhost.localdomain>
References: <20051207223414.GA4493@localhost.localdomain> <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com> <20051208193439.GB3776@localhost.localdomain> <20051208200440.GB15804@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208200440.GB15804@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 09:04:40PM +0100, Andi Kleen wrote:
> > > > The question is, what should be the default pcibus_to_node if there is no
> > > > pxm info? Answer seems like -1 -- in which case dma_alloc_pages and e1000
> > > > driver has to be fixed.
> > > 
> > > Why would they have to be fixed?
> > 
> > alloc_pages_node (used  by dma_alloc_pages) does not seem to do the check 
> > though.  I guess alloc_pages_node needs to be fixed then.
> 
> Or just fix the caller. I will do that and change the default to

That was my thinking earlier too, but shouldn't we have uniformity in
behaviour between kmalloc_node and alloc_pages_node wrt nodeid handling?  
IMHO it would be less confusing that way. alloc_pages_node is not that much 
of a fastpath routine anyways...

Thanks,
Kiran
