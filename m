Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVKPKkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVKPKkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVKPKkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:40:05 -0500
Received: from barclay.balt.net ([195.14.162.78]:4968 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S932597AbVKPKkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:40:03 -0500
Date: Wed, 16 Nov 2005 12:38:34 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051116103834.GC23140@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com> <20051115140023.GB9910@gemtek.lt> <Pine.LNX.4.58.0511161130350.30203@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511161130350.30203@sbz-30.cs.Helsinki.FI>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pekka, 

compiling kernel with a new patch :)

> And see if you can trigger the oops with the included patch applied. 
> Please leave the page and slab debugging config options on.
> 
> Thank you for testing!
> 
> 			Pekka
> 
> Index: 2.6/drivers/net/wireless/ipw2200.c
> ===================================================================
> --- 2.6.orig/drivers/net/wireless/ipw2200.c
> +++ 2.6/drivers/net/wireless/ipw2200.c
> @@ -11065,6 +11065,7 @@ static int ipw_pci_probe(struct pci_dev 
>  	return 0;
>  
>        out_remove_sysfs:
> +	ipw_disable_interrupts(priv);
>  	sysfs_remove_group(&pdev->dev.kobj, &ipw_attribute_group);
>        out_release_irq:
>  	free_irq(pdev->irq, priv);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
