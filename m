Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275383AbTHITQE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275382AbTHITPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:15:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44742 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275379AbTHITPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:15:01 -0400
Date: Sat, 9 Aug 2003 21:14:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ilya@theIlya.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill EXPORT_NO_SYMBOLS from meth.c
Message-ID: <20030809191451.GJ16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below kills an occurence of the obsolete EXPORT_NO_SYMBOLS 
from drivers/net/meth.c in 2.6.0-test3.

--- linux-2.6.0-test3-not-full/drivers/net/meth.c.old	2003-08-09 21:08:10.000000000 +0200
+++ linux-2.6.0-test3-not-full/drivers/net/meth.c	2003-08-09 21:08:41.000000000 +0200
@@ -844,9 +844,6 @@
 		printk("meth: error %i registering device \"%s\"\n",
 		       result, meth_devs->name);
 	else device_present++;
-#ifndef METH_DEBUG
-	EXPORT_NO_SYMBOLS;
-#endif
 	
 	return device_present ? 0 : -ENODEV;
 }


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

