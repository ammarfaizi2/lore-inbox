Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266290AbUGPG1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUGPG1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 02:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUGPG1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 02:27:46 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:29133 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266290AbUGPG1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 02:27:45 -0400
Date: Fri, 16 Jul 2004 08:33:45 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Andi Kleen <ak@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>, <netdev@oss.sgi.com>,
       <irda-users@lists.sourceforge.net>, Jean Tourrilhes <jt@hpl.hp.com>,
       <the_nihilant@autistici.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
In-Reply-To: <20040716061913.GB662@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0407160829560.14037-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004, Andi Kleen wrote:

> > According to include/asm-x86_64/dma-mapping.h there is no such override 
> > for x86-64. Hence the generic implementation is used which Oopses when 
> > called with dev=NULL in dma_alloc_coherent because it dereferences dev 
> > unconditionally.
> 
> The old pci_alloc_coherent supported hwdev == NULL under x86-64.
> dma_alloc_consistent() should too. I will fix that. 

Ok, thanks. This sounds like the right solution. I think most/all 
functions in include/asm-generic/dma-mapping.h are not prepared to accept 
dev=NULL parameters, so it's a bit more than just dma_alloc_coherent() :-(

Martin

