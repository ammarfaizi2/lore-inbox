Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCEXek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCEXek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 18:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCEXcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:32:36 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:53653 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261228AbVCEXYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:24:40 -0500
Date: Sun, 6 Mar 2005 00:21:53 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: domen@coderock.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, c.lucas@ifrance.com
Subject: Re: [patch 14/15] drivers/block/*: convert to pci_register_driver
Message-ID: <20050305232153.GA28664@electric-eye.fr.zoreil.com>
References: <20050305224327.781571F07A@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305224327.781571F07A@trashy.coderock.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org <domen@coderock.org> :
[...]
> diff -puN drivers/block/umem.c~pci_register_driver-drivers_block drivers/block/umem.c
> --- kj/drivers/block/umem.c~pci_register_driver-drivers_block	2005-03-05 16:12:16.000000000 +0100
> +++ kj-domen/drivers/block/umem.c	2005-03-05 16:12:16.000000000 +0100
> @@ -1185,7 +1185,7 @@ int __init mm_init(void)
>  
>  	printk(KERN_INFO DRIVER_VERSION " : " DRIVER_DESC "\n");
>  
> -	retval = pci_module_init(&mm_pci_driver);
> +	retval = pci_register_driver(&mm_pci_driver);
>  	if (retval)
>  		return -ENOMEM;

The return code is fine and does not need to be overwritten.
Imho it could be considered to be part of the patch.

--
Ueimor
