Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbSLKWW7>; Wed, 11 Dec 2002 17:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbSLKWW7>; Wed, 11 Dec 2002 17:22:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4992 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267323AbSLKWW4>;
	Wed, 11 Dec 2002 17:22:56 -0500
Date: Wed, 11 Dec 2002 14:30:43 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.51] Remove compile warning from  drivers/ide/pci/sc1200.c
Message-ID: <20021211223043.GC1067@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deleted an unused stack variable from sc1200_suspend.

diff -Nru a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c	Wed Dec 11 13:41:51 2002
+++ b/drivers/ide/pci/sc1200.c	Wed Dec 11 13:41:51 2002
@@ -427,8 +427,6 @@
 
 static int sc1200_suspend (struct pci_dev *dev, u32 state)
 {
-	ide_hwif_t	*hwif = NULL;
-
 	printk("SC1200: suspend(%u)\n", state);
 	/* You don't need to iterate over disks -- sysfs should have done that for you already */ 
 

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
