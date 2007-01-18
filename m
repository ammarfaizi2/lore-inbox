Return-Path: <linux-kernel-owner+w=401wt.eu-S932516AbXARVzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbXARVzl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbXARVzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:55:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3708 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932516AbXARVzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:55:41 -0500
Date: Thu, 18 Jan 2007 22:55:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jonathan@buzzard.org.uk, tlinux-users@linux.toshiba-dme.co.jp,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] proper prototype for tosh_smm()
Message-ID: <20070118215546.GE9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a proper prototype for tosh_smm() to 
include/linux/toshiba.h

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Jan 2007

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

