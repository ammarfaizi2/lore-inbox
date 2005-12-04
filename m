Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVLDVER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVLDVER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 16:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVLDVER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 16:04:17 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:56148 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932350AbVLDVEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 16:04:16 -0500
Message-ID: <43935A15.8010706@m1k.net>
Date: Sun, 04 Dec 2005 16:05:25 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Otavio Salvador <otavio@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/11] MEDIA: replace all uses of pci_module_init with
 pci_register_driver
References: <11336254301170-git-send-email-otavio@debian.org>
In-Reply-To: <11336254301170-git-send-email-otavio@debian.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otavio Salvador wrote:

>This patch replace all calls to pci_module_init, that's deprecated and
>will be removed in future, with pci_register_driver that should be
>the used function now.
>
>Signed-off-by: Otavio Salvador <otavio@debian.org>
>  
>
Acked-by: Michael Krufky <mkrufky@linuxtv.org>

>
>---
>
> drivers/media/radio/radio-gemtek-pci.c     |    2 +-
> drivers/media/radio/radio-maxiradio.c      |    2 +-
> drivers/media/video/bttv-driver.c          |    2 +-
> drivers/media/video/saa7134/saa7134-core.c |    2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)
>
>applies-to: f72516fc599b70f5507e6cf69b256b0da72b3646
>fc3bbed930173e0784960f17cf67c229e652f6a0
>diff --git a/drivers/media/radio/radio-gemtek-pci.c b/drivers/media/radio/radio-gemtek-pci.c
>index 630cc78..78b2888 100644
>--- a/drivers/media/radio/radio-gemtek-pci.c
>+++ b/drivers/media/radio/radio-gemtek-pci.c
>@@ -394,7 +394,7 @@ static struct pci_driver gemtek_pci_driv
> 
> static int __init gemtek_pci_init_module( void )
> {
>-	return pci_module_init( &gemtek_pci_driver );
>+	return pci_register_driver( &gemtek_pci_driver );
> }
> 
> static void __exit gemtek_pci_cleanup_module( void )
>diff --git a/drivers/media/radio/radio-maxiradio.c b/drivers/media/radio/radio-maxiradio.c
>index 02d39a5..7b33d8f 100644
>--- a/drivers/media/radio/radio-maxiradio.c
>+++ b/drivers/media/radio/radio-maxiradio.c
>@@ -337,7 +337,7 @@ static struct pci_driver maxiradio_drive
> 
> static int __init maxiradio_radio_init(void)
> {
>-	return pci_module_init(&maxiradio_driver);
>+	return pci_register_driver(&maxiradio_driver);
> }
> 
> static void __exit maxiradio_radio_exit(void)
>diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
>index 3c58a2a..cfb720d 100644
>--- a/drivers/media/video/bttv-driver.c
>+++ b/drivers/media/video/bttv-driver.c
>@@ -4253,7 +4253,7 @@ static int bttv_init_module(void)
> 	bttv_check_chipset();
> 
> 	bus_register(&bttv_sub_bus_type);
>-	return pci_module_init(&bttv_pci_driver);
>+	return pci_register_driver(&bttv_pci_driver);
> }
> 
> static void bttv_cleanup_module(void)
>diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
>index 1a093bf..18aa5d4 100644
>--- a/drivers/media/video/saa7134/saa7134-core.c
>+++ b/drivers/media/video/saa7134/saa7134-core.c
>@@ -1155,7 +1155,7 @@ static int saa7134_init(void)
> 	printk(KERN_INFO "saa7130/34: snapshot date %04d-%02d-%02d\n",
> 	       SNAPSHOT/10000, (SNAPSHOT/100)%100, SNAPSHOT%100);
> #endif
>-	return pci_module_init(&saa7134_pci_driver);
>+	return pci_register_driver(&saa7134_pci_driver);
> }
> 
> static void saa7134_fini(void)
>---
>0.99.9k
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

