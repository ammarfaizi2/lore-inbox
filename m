Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbTIKGMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbTIKGMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:12:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4583 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266127AbTIKGMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:12:45 -0400
Date: Thu, 11 Sep 2003 08:12:40 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [2.6 patch] remove duplicate SOUND_RME96XX option
Message-ID: <20030911061240.GU27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/oss/Kconfig in 2.6.0-test5 includes two SOUND_RME96XX entries.

The following patch removes one of them:

--- linux-2.6.0-test5+tr-full/sound/oss/Kconfig.old	2003-09-11 08:06:48.000000000 +0200
+++ linux-2.6.0-test5+tr-full/sound/oss/Kconfig	2003-09-11 08:09:00.000000000 +0200
@@ -237,13 +237,6 @@
 	tristate "PA Harmony audio driver"
 	depends on GSC_LASI && SOUND
 
-config SOUND_RME96XX
-	tristate "RME Hammerfall (RME96XX) support (EXPERIMENTAL)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && EXPERIMENTAL
-	help
-	  Say Y or M if you have a Hammerfall, Hammerfall light or Hammerfall
-	  DSP card from RME.
-
 config SOUND_SONICVIBES
 	tristate "S3 SonicVibes"
 	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

