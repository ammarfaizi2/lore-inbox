Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUJIRF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUJIRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJIRF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:05:58 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:56261 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S267235AbUJIRFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:05:44 -0400
Subject: Re: [Kernel-janitors] [PATCH 2.6][10/12] prep_pci.c replace
	pci_find_device with pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       benh@kernel.crashing.org, paulus@samba.org, greg@kroah.com
In-Reply-To: <35460000.1097192417@w-hlinder.beaverton.ibm.com>
References: <35460000.1097192417@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1097341535.3903.6.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 10:05:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 16:40, Hanna Linder wrote:
> @@ -1102,7 +1102,7 @@ prep_pib_init(void)
>  		}
>  	}
>  
> -	if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND,
> +	if ((dev = pci_get_device(PCI_VENDOR_ID_WINBOND,
>  				   PCI_DEVICE_ID_WINBOND_82C105, dev))){
>  		if (OpenPIC_Addr){
>  			/*

Missing pci_dev_put(dev) cleanup?

-scott

