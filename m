Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUH2Ha0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUH2Ha0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 03:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUH2Ha0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 03:30:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14515 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267189AbUH2HaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 03:30:24 -0400
Message-ID: <41318602.3060900@pobox.com>
Date: Sun, 29 Aug 2004 03:30:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add x86 implementation of dma_declare_coherent_memory
References: <200408290606.i7T66G08009639@hera.kernel.org>
In-Reply-To: <200408290606.i7T66G08009639@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> +void dma_release_declared_memory(struct device *dev)
> +{
> +	struct dma_coherent_mem *mem = dev->dma_mem;
> +	
> +	if(!mem)
> +		return;
> +	dev->dma_mem = NULL;
> +	kfree(mem->bitmap);
> +	kfree(mem);
> +}
> +EXPORT_SYMBOL(dma_release_declared_memory);


There seems to be an iounmap() call missing.

Or is it me who is missing something?  :)

	Jeff


