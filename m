Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266300AbUGAVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266300AbUGAVuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUGAVuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:50:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23529 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266300AbUGAVuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:50:15 -0400
Date: Thu, 1 Jul 2004 23:50:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: support@moxa.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused variable in mxser.c
Message-ID: <20040701215008.GB28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warning in 2.6.7-mm5:

<--  snip  -->

...
  CC [M]  drivers/char/mxser.o
drivers/char/mxser.c: In function `mxser_module_init':
drivers/char/mxser.c:617: warning: unused variable `index'
...

<--  snip  -->

Since the variable is in fact unused, the following patch simply removes 
it:

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-modular/drivers/char/mxser.c.old	2004-07-01 23:44:59.000000000 +0200
+++ linux-2.6.7-mm5-modular/drivers/char/mxser.c	2004-07-01 23:46:45.000000000 +0200
@@ -614,7 +614,6 @@
 	{
 		struct pci_dev *pdev = NULL;
 		int n = (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
-		int index = 0;
 		for (b = 0; b < n; b++) {
 			while ((pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev)))
 			{


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

