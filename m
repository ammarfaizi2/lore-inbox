Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVHXUZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVHXUZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVHXUZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:25:18 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:57079 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932122AbVHXUZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:25:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fqjGw090L8b5XpnJ1nWqe00o3GrCCdbZMIiKOPyTaUaEyk+wldwyFqXJkbOojgi5lwHV0p2Ih8gDGekupgLsRMSFPZ7+4kxXANVUtLRP9+HisYhLdsAuGcKYKzHUYekOvgvezKVwt4wWFN2uoKqYY/UKs1dYE4hu78m+vsl20O8=
Date: Thu, 25 Aug 2005 00:34:18 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050824203418.GB23715@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk> <20050824201301.GA23715@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824201301.GA23715@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 12:13:02AM +0400, Alexey Dobriyan wrote:
> > 	    sh64: need kernel headers that would make glibc happy enough
> > to build libc headers for that puppy;
> 
> binutils already compiled. Will drop a line. Or file a bug. :-\

By some miracle gcc is also compiled. As of now (sh64, allmodconfig):

arch/sh64/kernel/pci_sh5.c: In function `map_cayman_irq':
arch/sh64/kernel/pci_sh5.c:334: error: `IRQ_P2INTA' undeclared

arch/sh64/kernel/dma.c: In function `init_dma':
arch/sh64/kernel/dma.c:248: error: storage size of 'vcr' isn't known

arch/sh64/mm/hugetlbpage.c: At top level:
arch/sh64/mm/hugetlbpage.c:84: error: conflicting types for 'huge_ptep_get_and_clear'
include/linux/hugetlb.h:64: error: previous declaration of 'huge_ptep_get_and_clear' was here

arch/sh64/mm/hugetlbpage.c: In function `huge_ptep_get_and_clear':
arch/sh64/mm/hugetlbpage.c:89: error: `i' undeclared

arch/sh64/mm/hugetlbpage.c:90:16: macro "pte_clear" requires 3 arguments, but only 1 given
arch/sh64/mm/hugetlbpage.c:90: error: `pte_clear' undeclared (first use in this
function)
arch/sh64/mm/hugetlbpage.c:91: error: `pte' undeclared (first use in this function)

arch/sh64/mach-sim/setup.c:25:11: error: unable to open 'asm/addrspace.h'
	exists only in asm-{sh, m32r, mips}

