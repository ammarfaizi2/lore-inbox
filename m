Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRF3Urr>; Sat, 30 Jun 2001 16:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264331AbRF3Uri>; Sat, 30 Jun 2001 16:47:38 -0400
Received: from iris.kkt.bme.hu ([152.66.114.1]:21005 "HELO iris.kkt.bme.hu")
	by vger.kernel.org with SMTP id <S264329AbRF3UrZ>;
	Sat, 30 Jun 2001 16:47:25 -0400
Date: Sat, 30 Jun 2001 22:47:23 +0200 (CEST)
From: PALFFY Daniel <dpalffy@kkt.bme.hu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: 2.4.5-acX, airo_cs
Message-ID: <Pine.LNX.4.21.0106302244420.18632-100000@iris.kkt.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

A small patch to airo.c to allow the module to load even if no pci or isa
cards are found, because airo_cs needs the airo module to load.

--- linux/drivers/net/wireless/airo.c~	Sat Jun 30 22:37:10 2001
+++ linux/drivers/net/wireless/airo.c	Sat Jun 30 22:37:33 2001
@@ -2988,9 +2988,7 @@
 	 * fails with an error other than -ENODEV, instead of proceeding,
 	 * if ISA devs are present.
 	 */
-	if (have_isa_dev)
-		return 0;
-	return rc;
+	return 0;
 }
 
 static void __exit airo_cleanup_module( void )


--
Dani
			...and Linux for all.


