Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVAUKLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVAUKLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAUKI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:08:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262288AbVAUKHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:07:40 -0500
Date: Fri, 21 Jan 2005 11:07:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/configs.c: make a variable static
Message-ID: <20050121100737.GA3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/kernel/Makefile.old	2004-12-12 02:45:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/Makefile	2004-12-12 02:45:18.000000000 +0100
@@ -48,7 +48,7 @@
 	$(call if_changed,gzip)
 
 quiet_cmd_ikconfiggz = IKCFG   $@
-      cmd_ikconfiggz = (echo "const char kernel_config_data[] = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;") > $@
+      cmd_ikconfiggz = (echo "static const char kernel_config_data[] = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;") > $@
 targets += config_data.h
 $(obj)/config_data.h: $(obj)/config_data.gz FORCE
 	$(call if_changed,ikconfiggz)

