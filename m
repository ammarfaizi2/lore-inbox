Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbSLRAUH>; Tue, 17 Dec 2002 19:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLRAUG>; Tue, 17 Dec 2002 19:20:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62462 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267027AbSLRAUG>; Tue, 17 Dec 2002 19:20:06 -0500
Date: Wed, 18 Dec 2002 01:26:22 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] MSNDCLAS_HAVE_BOOT and MSNDPIN_HAVE_BOOT shouldn't ask questions
Message-ID: <20021218002621.GH27658@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

2.5.50 included a change from -ac which changed MSNDCLAS_HAVE_BOOT and 
MSNDPIN_HAVE_BOOT to asked questions. This is wrong (I know since I was 
the one who wrote the patch Alan picked up...).

They shouldn't ask questions, the following patch reverts my buggy 
change:

--- linux-2.5.50/sound/oss/Kconfig.old	2002-11-30 20:47:01.000000000 +0100
+++ linux-2.5.50/sound/oss/Kconfig	2002-11-30 20:47:25.000000000 +0100
@@ -293,7 +293,7 @@
 	depends on SOUND_PRIME && SOUND_MSNDCLAS=y
 
 config MSNDCLAS_HAVE_BOOT
-	bool "Have MSNDINIT.BIN firmware file"
+	bool
 	depends on SOUND_MSNDCLAS=y
 	default y
 
@@ -355,7 +355,7 @@
 	depends on SOUND_PRIME && SOUND_MSNDPIN=y
 
 config MSNDPIN_HAVE_BOOT
-	bool "Have PNDSPINI.BIN firmware file"
+	bool
 	depends on SOUND_MSNDPIN=y
 	default y
 


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

