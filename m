Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVGaShn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVGaShn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVGaShn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:37:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:35977 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261868AbVGaShi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:37:38 -0400
Subject: Re: default values for pci dma_mask and coherent_dma_mask
From: Lee Revell <rlrevell@joe-job.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42ECA997.8020908@colorfullife.com>
References: <42ECA997.8020908@colorfullife.com>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 14:37:34 -0400
Message-Id: <1122835054.12500.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 12:36 +0200, Manfred Spraul wrote:
> I intend to add these lines to the 
> driver:
> 
> +    if (pci_set_dma_mask(pci_dev, 0x0000007fffffffffULL)) {
> +         printk(KERN_INFO "forcedeth: 64-bit DMA failed, using
> 32-bit 
> addressing for device %s.\n",

Please don't do this.  Instead, add a DMA_40BIT_MASK define to
dma_mapping.h.

Lee

