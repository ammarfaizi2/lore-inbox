Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWCXQ4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWCXQ4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWCXQ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:56:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43783 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751137AbWCXQ4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:56:10 -0500
Date: Fri, 24 Mar 2006 17:56:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let BLK_DEV_RAM_COUNT depend on BLK_DEV_RAM
Message-ID: <20060324165608.GE22727@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's purely cosmetical, but with the patch there's no longer a 
BLK_DEV_RAM_COUNT setting in the .config if BLK_DEV_RAM=n.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Mar 2006

--- linux-2.6.16-rc6-mm1-full/drivers/block/Kconfig.old	2006-03-18 05:42:06.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/block/Kconfig	2006-03-18 05:42:39.000000000 +0100
@@ -383,8 +383,9 @@
 	  thus say N here.
 
 config BLK_DEV_RAM_COUNT
-	int "Default number of RAM disks" if BLK_DEV_RAM
+	int "Default number of RAM disks"
 	default "16"
+	depends on BLK_DEV_RAM
 	help
 	  The default value is 16 RAM disks. Change this if you know what
 	  are doing. If you boot from a filesystem that needs to be extracted

