Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWIDMy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWIDMy0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWIDMy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:54:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43706 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964808AbWIDMyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:54:25 -0400
Subject: Re: [PATCH] [MM] 1/10 pci_module_init() conversion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henne <henne@nachtwindheim.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <44FC1E44.1080202@nachtwindheim.de>
References: <44FC1E44.1080202@nachtwindheim.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:16:57 +0100
Message-Id: <1157375818.30801.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 14:38 +0200, ysgrifennodd Henne:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> pci_module_init convertion in ata_generic.c.
> For mm-tree only.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> ---
> 
> --- linux-2.6.18-rc5-mm1/drivers/ata/ata_generic.c	2006-09-13 17:54:15.000000000 +0200
> +++ linux/drivers/ata/ata_generic.c	2006-09-13 21:34:45.851360336 +0200
> @@ -230,7 +230,7 @@
>  
>  static int __init ata_generic_init(void)
>  {
> -	return pci_module_init(&ata_generic_pci_driver);
> +	return pci_register_driver(&ata_generic_pci_driver);
>  }

Acked-by: Alan Cox <alan@redhat.com> but please apply as follows to keep
revision id straight

--- linux.vanilla-2.6.18-rc5-mm1/drivers/ata/ata_generic.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/ata/ata_generic.c	2006-09-04 13:39:11.975788992 +0100
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "ata_generic"
-#define DRV_VERSION "0.2.6"
+#define DRV_VERSION "0.2.7"
 
 /*
  *	A generic parallel ATA driver using libata
@@ -230,7 +230,7 @@
 
 static int __init ata_generic_init(void)
 {
-	return pci_module_init(&ata_generic_pci_driver);
+	return pci_register_driver(&ata_generic_pci_driver);
 }
 
 

