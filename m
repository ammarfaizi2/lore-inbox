Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVENMIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVENMIC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 08:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVENMIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 08:08:02 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:4892 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262747AbVENMH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 08:07:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FtH+RO/zzjrXc/WdcKnptHr2iFuI+tFRJD1g2YytvN+vvEQjPkImVNGIhLYKN3qqgxXMgDizIpYxG1o+I0OzVIKbrfPzAo/XWWyp3JykT9D6/1am658ZGwdEVKQ2SHMbGduHlOgS3VpQaTlz1oOp+CBFt5ZEXMFN3GSBa1LrY6Q=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Domen Puncer <domen@coderock.org>
Subject: Re: 2.6.12-rc4-kj (dma_mask-drivers_block_umem.patch)
Date: Sat, 14 May 2005 16:11:54 +0400
User-Agent: KMail/1.7.2
Cc: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20050513165729.GA31208@nd47.coderock.org>
In-Reply-To: <20050513165729.GA31208@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505141611.54373.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 May 2005 20:57, Domen Puncer wrote:
> --- quilt.orig/drivers/block/umem.c
> +++ quilt/drivers/block/umem.c

> -	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
> -	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
	   ^^^
> +	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
> +	    !pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
	   ^^^
>  		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
>  		return  -ENOMEM;

A typo?
