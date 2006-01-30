Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWA3KB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWA3KB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWA3KB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:01:26 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:31938 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S932194AbWA3KBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:01:24 -0500
Date: Mon, 30 Jan 2006 12:01:33 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH RESEND] move swiotlb.h header file to asm-generic
In-reply-to: <200601301049.41854.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jon Mason <jdmason@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, "Luck, Tony" <tony.luck@intel.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
Message-id: <20060130100133.GH23968@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060130094434.GG23968@granada.merseine.nu>
 <200601301049.41854.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 10:49:41AM +0100, Andi Kleen wrote:
> On Monday 30 January 2006 10:44, Muli Ben-Yehuda wrote:
> > This patch:
> > 
> > - creates asm-generic/swiotlb.h
> > - makes it use 'enum dma_data_direction dir' rather than 'int dir'
> > - updates x86-64 and IA64 to use the common swiotlb.h
> > - fixes the resulting fall out (s/int dir/enum dma_data_direction dir/
> >   all over the place).
> 
> Al Viro will likely flame you badly for that enum change. Apparently it 
> causes some trouble in sparse. Frankly i don't see the point neither.
> It just makes the code harder to read and creates a monstrosity of a patch 
> and doesn't give you anything.

DMA-API.txt uses the enum form; so do arm, frv, mips, parisc and
powerpc. x86-64, IA64, alpha, sparc, sparc64 and v850 use the int
form. I really couldn't care less whether we use an enum or an int for
the DMA data direction in the DMA API, as long as all archs used the
same thing. I don't feel comfortable putting swiotlb.h in generic code
unless it really is generic. So... which should it be?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

