Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUDRNcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUDRNcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 09:32:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3560 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264165AbUDRNcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 09:32:48 -0400
Date: Sun, 18 Apr 2004 15:32:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove the STANDALONE dependency on EXPERIMENTAL
Message-ID: <20040418133239.GO14212@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a good reason why STANDALONE depends on EXPERIMENTAL?

I disabled EXPERIMENTAL and was no longer able to enable STANDALONE.

Unless there's a good reason, I'd suggest the following patch:


--- linux-2.6.5-mm6-full/init/Kconfig.old	2004-04-16 20:27:07.000000000 +0200
+++ linux-2.6.5-mm6-full/init/Kconfig	2004-04-16 20:27:17.000000000 +0200
@@ -42,7 +42,7 @@
 	  If unsure, say Y
 
 config STANDALONE
-	bool "Select only drivers that don't need compile-time external firmware" if EXPERIMENTAL
+	bool "Select only drivers that don't need compile-time external firmware"
 	default n
 	help
 	  Select this option if you don't have magic firmware for drivers that

\
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

