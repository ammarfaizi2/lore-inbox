Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUHJEhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUHJEhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267422AbUHJEhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:37:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:52389 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267409AbUHJEhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:37:12 -0400
Date: Mon, 9 Aug 2004 21:37:10 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Remove spaces from MTD pci_driver.name field
Message-ID: <20040810043710.GA11719@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,

Spaces in driver names show up as spaces in the sysfs tree.
While there is no documented requirement that spaces not
exist in sysfs paths, my understanding is that they are not 
desired.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


===== drivers/mtd/maps/pci.c 1.6 vs edited =====
--- 1.6/drivers/mtd/maps/pci.c	Thu Jul 15 10:31:48 2004
+++ edited/drivers/mtd/maps/pci.c	Mon Aug  9 18:06:34 2004
@@ -362,7 +362,7 @@
 }
 
 static struct pci_driver mtd_pci_driver = {
-	.name =		"MTD PCI",
+	.name =		"MTD_PCI",
 	.probe =	mtd_pci_probe,
 	.remove =	__devexit_p(mtd_pci_remove),
 	.id_table =	mtd_pci_ids,
===== drivers/mtd/maps/scb2_flash.c 1.4 vs edited =====
--- 1.4/drivers/mtd/maps/scb2_flash.c	Thu Jul 15 10:31:48 2004
+++ edited/drivers/mtd/maps/scb2_flash.c	Mon Aug  9 18:06:53 2004
@@ -229,7 +229,7 @@
 };
 
 static struct pci_driver scb2_flash_driver = {
-	.name =     "Intel SCB2 BIOS Flash",
+	.name =     "Intel_SCB2_BIOS",
 	.id_table = scb2_flash_pci_ids,
 	.probe =    scb2_flash_probe,
 	.remove =   __devexit_p(scb2_flash_remove),

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
