Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTB0X0Q>; Thu, 27 Feb 2003 18:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTB0X0Q>; Thu, 27 Feb 2003 18:26:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22239 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267256AbTB0X0P>; Thu, 27 Feb 2003 18:26:15 -0500
Date: Fri, 28 Feb 2003 00:36:27 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: David Woodhouse <dwmw2@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] include cfi_cmdset_0020 in drivers/mtd/chips/Makefile
Message-ID: <20030227233627.GW7685@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-pre5 includes drivers/mtd/chips/cfi_cmdset_0020.c but doesn't 
compile it. The following patch fixes it:

--- linux-2.4.21-pre5-full/drivers/mtd/chips/Makefile.old	2003-02-28 00:28:56.000000000 +0100
+++ linux-2.4.21-pre5-full/drivers/mtd/chips/Makefile	2003-02-28 00:32:43.000000000 +0100
@@ -17,6 +17,7 @@
 obj-$(CONFIG_MTD)		+= chipreg.o
 obj-$(CONFIG_MTD_AMDSTD)	+= amd_flash.o 
 obj-$(CONFIG_MTD_CFI)		+= cfi_probe.o
+obj-$(CONFIG_MTD_CFI_STAA)	+= cfi_cmdset_0020.o
 obj-$(CONFIG_MTD_CFI_AMDSTD)	+= cfi_cmdset_0002.o
 obj-$(CONFIG_MTD_CFI_INTELEXT)	+= cfi_cmdset_0001.o
 obj-$(CONFIG_MTD_GEN_PROBE)	+= gen_probe.o


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

