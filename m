Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVCPPAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVCPPAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVCPPAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:00:04 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:9430 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262613AbVCPO6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:58:45 -0500
To: Christoph Hellwig <hch@infradead.org>
cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, riel@redhat.com, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: Your message of "Wed, 16 Mar 2005 14:31:30 GMT."
             <20050316143130.GA21959@infradead.org> 
Date: Wed, 16 Mar 2005 14:58:37 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DBZyo-0003Ut-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 16, 2005 at 11:48:29AM +0000, Keir Fraser wrote:
> > This patch cleans up AGP driver treatment of bus/device memory. Every
> > use of virt_to_phys/phys_to_virt should properly be converting between
> > virtual and bus addresses: this distinction really matters for the Xen
> > hypervisor.
> 
> It's bogus either way.  You must never use virt_to_phys or virt_to_bus
> for bus address.  For systems with an IOMMU there's no 1:1 mapping.

Well, I'd say it's less bogus: it makes the intention clearer, and it
is a 'good enough' improvement for Xen. Indeed, it's good enough for
all the architectures that actually use the AGP drivers (all have no
IOMMU, or an IOMMU only to support legacy 32-bit I/O interfaces). 

 -- Keir
