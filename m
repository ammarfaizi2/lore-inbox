Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTEKBsa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 21:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTEKBsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 21:48:30 -0400
Received: from smtp2.wanadoo.es ([62.37.236.136]:39606 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S261925AbTEKBs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 21:48:28 -0400
Message-ID: <3EBDAEE9.3080608@wanadoo.es>
Date: Sun, 11 May 2003 04:01:13 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       marcelo <marcelo@conectiva.com.br>
Subject: [PATCH] avoid two sym53c8xx names
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

To avoid that it has two modules with same name:

patch for 2.4.21-rc2:
--cut--
diff -Nuar linux/drivers/scsi/Makefile linux.xose/drivers/scsi/Makefile
--- linux/drivers/scsi/Makefile 2003-05-11 02:53:40.000000000 +0200
+++ linux.xose/drivers/scsi/Makefile    2003-05-11 03:52:41.000000000 +0200
@@ -97,7 +97,7 @@
 obj-$(CONFIG_SCSI_NCR53C7xx)   += 53c7,8xx.o
 subdir-$(CONFIG_SCSI_SYM53C8XX_2)      += sym53c8xx_2
 ifeq ($(CONFIG_SCSI_SYM53C8XX_2),y)
-  obj-$(CONFIG_SCSI_SYM53C8XX_2)       += sym53c8xx_2/sym53c8xx.o
+  obj-$(CONFIG_SCSI_SYM53C8XX_2)       += sym53c8xx_2/sym53c8xx_2.o
 endif
 obj-$(CONFIG_SCSI_SYM53C8XX)   += sym53c8xx.o
 obj-$(CONFIG_SCSI_NCR53C8XX)   += ncr53c8xx.o
--end--

-thanks-

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

