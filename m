Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTF2Su1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTF2Su1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:50:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31471 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262073AbTF2SuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:50:20 -0400
Date: Sun, 29 Jun 2003 21:04:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch] 2.5.73-mm2: let CONFIG_TC35815 depend on CONFIG_TOSHIBA_JMR3927
Message-ID: <20030629190431.GB282@fs.tum.de>
References: <20030627202130.066c183b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627202130.066c183b.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following problem seems to come from Linus' tree:

I got an error at the final linking with CONFIG_TC35815 enabled since
the variables tc_readl and tc_writel are not available.

The only place where they are defined is arch/mips/pci/ops-jmr3927.c, so 
I assume the following was intended:


--- linux-2.5.73-mm2/drivers/net/Kconfig.old	2003-06-28 11:14:16.000000000 +0200
+++ linux-2.5.73-mm2/drivers/net/Kconfig	2003-06-29 20:55:16.000000000 +0200
@@ -1397,7 +1397,7 @@
 
 config TC35815
 	tristate "TOSHIBA TC35815 Ethernet support"
-	depends on NET_PCI && PCI
+	depends on NET_PCI && PCI && TOSHIBA_JMR3927
 
 config DGRS
 	tristate "Digi Intl. RightSwitch SE-X support"


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

