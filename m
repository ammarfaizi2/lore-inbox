Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWJPKsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWJPKsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWJPKsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:48:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47300 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750988AbWJPKsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:48:01 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: x86-64 mmconfig missing printk levels.
Date: Mon, 16 Oct 2006 12:38:37 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, gregkh@suse.de
References: <20061011182105.GA1974@redhat.com>
In-Reply-To: <20061011182105.GA1974@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161238.37282.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 20:21, Dave Jones wrote:
> Trivial bits..

Would be more for Greg.

-Andi

> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- local-git/arch/x86_64/pci/mmconfig.c~	2006-10-11 14:18:57.000000000 -0400
> +++ local-git/arch/x86_64/pci/mmconfig.c	2006-10-11 14:19:28.000000000 -0400
> @@ -220,7 +220,7 @@ void __init pci_mmcfg_init(int type)
>  
>  	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
>  	if (pci_mmcfg_virt == NULL) {
> -		printk("PCI: Can not allocate memory for mmconfig structures\n");
> +		printk(KERN_ERR "PCI: Can not allocate memory for mmconfig structures\n");
>  		return;
>  	}
>  	for (i = 0; i < pci_mmcfg_config_num; ++i) {
> @@ -228,7 +228,7 @@ void __init pci_mmcfg_init(int type)
>  		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
>  							 MMCONFIG_APER_MAX);
>  		if (!pci_mmcfg_virt[i].virt) {
> -			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
> +			printk(KERN_ERR "PCI: Cannot map mmconfig aperture for segment %d\n",
>  			       pci_mmcfg_config[i].pci_segment_group_number);
>  			return;
>  		}
> 
