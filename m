Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVCRAQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVCRAQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCRAQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:16:38 -0500
Received: from ozlabs.org ([203.10.76.45]:10462 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261398AbVCRAQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:16:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16954.7656.838769.483631@cargo.ozlabs.ibm.com>
Date: Fri, 18 Mar 2005 11:16:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       riel@redhat.com, Ian.Pratt@cl.cam.ac.uk, kurt@garloff.de,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <1111067594.1213.27.camel@localhost.localdomain>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
	<16952.41973.751326.592933@cargo.ozlabs.ibm.com>
	<200503161406.01788.jbarnes@engr.sgi.com>
	<29ab1884ee5724e9efcfe43f14d13376@cl.cam.ac.uk>
	<16953.20279.77584.501222@cargo.ozlabs.ibm.com>
	<1111067594.1213.27.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> On Iau, 2005-03-17 at 09:34, Paul Mackerras wrote:
> > This code needs real physical addresses, which are not the same things
> > as bus addresses.  
> 
> Not always. The code needs platform specific goodies. We've only never
> been burned so far because there isn't a box with an IOMMU and AGPGART
> where one maps through the other.

That sounds like a good way to make AGP accesses slower. :)

Seriously, given that AGP is a technology that is being superseded by
PCI Express, I think it's reasonable to look at the range of current
implementations to see what we have to cope with.  So I don't think
it's worth worrying too much about the possibility of GARTs that go
through the IOMMU.  However, the idea of having phys_to_agp/agp_to_phys
(or virt_to_agp/agp_to_virt) sounds like it wouldn't be too much
effort, if it would help Xen.

Paul.
