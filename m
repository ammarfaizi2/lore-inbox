Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVGHVvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVGHVvY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVGHVtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:49:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20997 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262829AbVGHVsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:48:08 -0400
Date: Fri, 8 Jul 2005 23:48:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [2.6 patch] SCSI_SATA has to be a tristate
Message-ID: <20050708214802.GK3671@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI=m must disallow static drivers.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Jul 2005

--- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.000000000 +0200
+++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.000000000 +0200
@@ -447,7 +447,7 @@
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	bool "Serial ATA (SATA) support"
+	tristate "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers
