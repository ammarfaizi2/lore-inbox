Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTICRgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTICReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:34:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14796 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263842AbTICReb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:34:31 -0400
Date: Wed, 3 Sep 2003 19:34:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.6 patch] COSA is no longer BROKEN
Message-ID: <20030903173417.GC18025@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the compilation of cosa.c was already fixed in your BK tree, the
following patch removes the dependency on BROKEN:

--- linux-2.6.0-test4-not-full/drivers/net/wan/Kconfig	2003-09-02 17:24:53.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/wan/Kconfig	2003-09-02 17:24:53.000000000 +0200
@@ -35,7 +35,7 @@
 # The COSA/SRP driver has not been tested as non-modular yet.
 config COSA
 	tristate "COSA/SRP sync serial boards support"
-	depends on WAN && ISA && m && BROKEN
+	depends on WAN && ISA && m
 	---help---
 	  This is a driver for COSA and SRP synchronous serial boards. These
 	  boards allow to connect synchronous serial devices (for example


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

