Return-Path: <linux-kernel-owner+w=401wt.eu-S932170AbXACXJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbXACXJa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbXACXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:09:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1038 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932170AbXACXJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:09:28 -0500
Date: Thu, 4 Jan 2007 00:09:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jonathan@buzzard.org.uk
Cc: tlinux-users@linux.toshiba-dme.co.jp, linux-kernel@vger.kernel.org
Subject: [2.6 patch] proper prototype for tosh_smm()
Message-ID: <20070103230931.GQ20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This atch adds a proper prototype for tosh_smm() to 
include/linux/toshiba.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/neofb.c   |    1 -
 include/linux/toshiba.h |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.20-rc2-mm1/include/linux/toshiba.h.old	2007-01-03 23:03:10.000000000 +0100
+++ linux-2.6.20-rc2-mm1/include/linux/toshiba.h	2007-01-03 23:03:25.000000000 +0100
@@ -33,4 +33,6 @@
 	unsigned int edi __attribute__ ((packed));
 } SMMRegisters;
 
+int tosh_smm(SMMRegisters *regs);
+
 #endif
--- linux-2.6.20-rc2-mm1/drivers/video/neofb.c.old	2007-01-03 23:03:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/video/neofb.c	2007-01-03 23:03:39.000000000 +0100
@@ -66,7 +66,6 @@
 #include <linux/init.h>
 #ifdef CONFIG_TOSHIBA
 #include <linux/toshiba.h>
-extern int tosh_smm(SMMRegisters *regs);
 #endif
 
 #include <asm/io.h>

