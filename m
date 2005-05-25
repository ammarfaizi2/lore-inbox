Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVEYLlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVEYLlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVEYLlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:41:21 -0400
Received: from coderock.org ([193.77.147.115]:30598 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262238AbVEYLjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:39:05 -0400
Date: Wed, 25 May 2005 13:38:55 +0200
From: Domen Puncer <domen@coderock.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       nettwerk@valinux.com, jerdfelt@valinux.com, neilb@cse.unsw.edu.au
Subject: Re: [KJ] Re: 2.6.12-rc4-kj (dma_mask-drivers_block_umem.patch)
Message-ID: <20050525113855.GF3851@nd47.coderock.org>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, nettwerk@valinux.com,
	jerdfelt@valinux.com, neilb@cse.unsw.edu.au
References: <20050513165729.GA31208@nd47.coderock.org> <200505141611.54373.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505141611.54373.adobriyan@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No replies, so I'm adding mails from source to Cc:

On 14/05/05 16:11 +0400, Alexey Dobriyan wrote:
> On Friday 13 May 2005 20:57, Domen Puncer wrote:
> > --- quilt.orig/drivers/block/umem.c
> > +++ quilt/drivers/block/umem.c
> 
> > -	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
> > -	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
> 	   ^^^
> > +	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
> > +	    !pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
> 	   ^^^
> >  		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
> >  		return  -ENOMEM;
> 
> A typo?
