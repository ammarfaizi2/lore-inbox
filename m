Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVCPPFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVCPPFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVCPPFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:05:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20170 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262615AbVCPPBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:01:36 -0500
Date: Wed, 16 Mar 2005 10:01:07 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <20050316143130.GA21959@infradead.org>
Message-ID: <Pine.LNX.4.61.0503160959530.4104@chimarrao.boston.redhat.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <20050316143130.GA21959@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005, Christoph Hellwig wrote:
> On Wed, Mar 16, 2005 at 11:48:29AM +0000, Keir Fraser wrote:
> > This patch cleans up AGP driver treatment of bus/device memory. Every
> > use of virt_to_phys/phys_to_virt should properly be converting between
> > virtual and bus addresses: this distinction really matters for the Xen
> > hypervisor.
> 
> It's bogus either way.  You must never use virt_to_phys or virt_to_bus
> for bus address.  For systems with an IOMMU there's no 1:1 mapping.

In the case of AGP, the AGPGART effectively _is_ the
IOMMU.  Calculating the addresses right for programming
the AGPGART is probably worth fixing.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
