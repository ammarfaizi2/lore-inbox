Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUC1UpA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUC1UiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:38:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40672 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262471AbUC1UhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:37:00 -0500
Message-ID: <4067375E.4040206@pobox.com>
Date: Sun, 28 Mar 2004 15:36:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6-BK] Allow arch-specific pci_dma_set_mask
References: <20040327000639.GA29290@plexity.net>
In-Reply-To: <20040327000639.GA29290@plexity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> Jeff, 
> 
> Following is a patch that allows for architectures to override 
> pci_set_dma_mask and friends for systems that need to do so such
> as the ARM IXP425. Instead of having invidual HAVE_ARCH_FOO
> for each of the three mask functions, I think it just makes more
> sense to have one for overrdding all three since chances are
> if you need to override one, you need to do so for all of them.
> 
> Tnx,
> ~Deepak
> 
> ===== drivers/pci/pci.c 1.63 vs edited =====
> --- 1.63/drivers/pci/pci.c	Sun Mar 14 12:17:06 2004
> +++ edited/drivers/pci/pci.c	Fri Mar 26 16:58:01 2004
> @@ -658,6 +658,10 @@
>  	}
>  }
>  
> +#ifndef HAVE_ARCH_PCI_SET_DMA_MASK
> +/*
> + * These can be overridden by arch-specific implementations
> + */
>  int
>  pci_set_dma_mask(struct pci_dev *dev, u64 mask)


Looks OK to me, but it's really up to arch people.  I just follow the 
API I'm given.  :)

	Jeff



