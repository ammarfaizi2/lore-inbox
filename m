Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTIPTyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 15:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTIPTye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 15:54:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53709 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262489AbTIPTya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 15:54:30 -0400
Date: Tue, 16 Sep 2003 21:54:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>,
       "Krishnakumar. R" <krishnakumar@naturesoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.0-test5-mm2: ISTALLION UP compile is fixed
Message-ID: <20030916195422.GE17690@fs.tum.de>
References: <20030914234843.20cea5b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 11:48:43PM -0700, Andrew Morton wrote:
>...
> +istallion-build-fix.patch
> 
>  Compile fix
>...

This patch fixed the UP compile of this driver.

The following patch does the according BROKEN -> BROKEN_ON_SMP for the 
Kconfig file:

--- linux-2.6.0-test5-mm2-no-smp/drivers/char/Kconfig.old	2003-09-15 23:27:32.000000000 +0200
+++ linux-2.6.0-test5-mm2-no-smp/drivers/char/Kconfig	2003-09-15 23:29:09.000000000 +0200
@@ -370,7 +370,7 @@
 
 config ISTALLION
 	tristate "Stallion EC8/64, ONboard, Brumby support"
-	depends on STALDRV && BROKEN
+	depends on STALDRV && BROKEN_ON_SMP
 	help
 	  If you have an EasyConnection 8/64, ONboard, Brumby or Stallion
 	  serial multiport card, say Y here. Make sure to read


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

