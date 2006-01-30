Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWA3KKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWA3KKD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWA3KKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:10:02 -0500
Received: from ns2.suse.de ([195.135.220.15]:34784 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932198AbWA3KKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:10:01 -0500
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH RESEND] move swiotlb.h header file to asm-generic
Date: Mon, 30 Jan 2006 11:08:39 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Jon Mason <jdmason@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, "Luck, Tony" <tony.luck@intel.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
References: <20060130094434.GG23968@granada.merseine.nu> <200601301049.41854.ak@suse.de> <20060130100133.GH23968@granada.merseine.nu>
In-Reply-To: <20060130100133.GH23968@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301108.39751.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 11:01, Muli Ben-Yehuda wrote:
> On Mon, Jan 30, 2006 at 10:49:41AM +0100, Andi Kleen wrote:
> > On Monday 30 January 2006 10:44, Muli Ben-Yehuda wrote:
> > > This patch:
> > > 
> > > - creates asm-generic/swiotlb.h
> > > - makes it use 'enum dma_data_direction dir' rather than 'int dir'
> > > - updates x86-64 and IA64 to use the common swiotlb.h
> > > - fixes the resulting fall out (s/int dir/enum dma_data_direction dir/
> > >   all over the place).
> > 
> > Al Viro will likely flame you badly for that enum change. Apparently it 
> > causes some trouble in sparse. Frankly i don't see the point neither.
> > It just makes the code harder to read and creates a monstrosity of a patch 
> > and doesn't give you anything.
> 
> DMA-API.txt uses the enum form; so do arm, frv, mips, parisc and
> powerpc. x86-64, IA64, alpha, sparc, sparc64 and v850 use the int
> form. I really couldn't care less whether we use an enum or an int for
> the DMA data direction in the DMA API, as long as all archs used the
> same thing. I don't feel comfortable putting swiotlb.h in generic code
> unless it really is generic. So... which should it be?

I vote for int.

-Andi

