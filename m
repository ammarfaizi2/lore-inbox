Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272130AbTG2W1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272137AbTG2W1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:27:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45031 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272130AbTG2W1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:27:16 -0400
Date: Wed, 30 Jul 2003 00:27:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Herbert Valerio Riedel <hvr@gnu.org>,
       Fruhwirth Clemens <clemens@endorphin.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.6 patch] let BLK_DEV_CRYPTOLOOP depend on EXPERIMENTAL
Message-ID: <20030729222702.GV28767@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After reading through my linux-kernel folder, I'd suggest the following
patch to let BLK_DEV_CRYPTOLOOP depend on EXPERIMENTAL (once Cryptoloop
is more stable it's always possible to remove the EXPERIMENTAL):

--- linux-2.6.0-test2/drivers/block/Kconfig.old	2003-07-30 00:22:20.000000000 +0200
+++ linux-2.6.0-test2/drivers/block/Kconfig	2003-07-30 00:22:46.000000000 +0200
@@ -265,7 +265,7 @@
 config BLK_DEV_CRYPTOLOOP
 	tristate "Cryptoloop Support"
 	select CRYPTO
-	depends on BLK_DEV_LOOP
+	depends on BLK_DEV_LOOP && EXPERIMENTAL
 	---help---
 	  Say Y here if you want to be able to use the ciphers that are 
 	  provided by the CryptoAPI as loop transformation. This might be


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

