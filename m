Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWIDNcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWIDNcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWIDNct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:32:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23479 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964927AbWIDNcs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:32:48 -0400
Subject: Re: [PATCH] [MM] 6/10 pci_module_init() conversion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henne <henne@nachtwindheim.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <44FC231C.1000807@nachtwindheim.de>
References: <44FC231C.1000807@nachtwindheim.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:55:22 +0100
Message-Id: <1157378122.30801.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 14:59 +0200, ysgrifennodd Henne:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> pci_module_init() convertion in olympic.c
> This one works on linus tree(2.6.18-rc6) too.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> ---
> 
> --- linux-2.6.18-rc5-mm1/drivers/net/tokenring/olympic.c	2006-09-13 17:46:50.000000000 +0200
> +++ linux/drivers/net/tokenring/olympic.c	2006-09-13 22:23:50.475145848 +0200
> @@ -1771,7 +1771,7 @@
>  
>  static int __init olympic_pci_init(void) 
>  {
> -	return pci_module_init (&olympic_driver) ; 
> +	return pci_register_driver(&olympic_driver) ; 
>  }

Acked-by: Alan Cox <alan@redhat.com>

