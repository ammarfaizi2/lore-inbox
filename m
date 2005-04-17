Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVDQTYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVDQTYV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVDQTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:22:54 -0400
Received: from hermes.domdv.de ([193.102.202.1]:37137 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261423AbVDQTUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:20:18 -0400
Message-ID: <4262B6F1.80509@domdv.de>
Date: Sun, 17 Apr 2005 21:20:17 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
Subject: [RFC][PATCH 3/4] AES assembler implementation for x86_64
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000403040605010606010308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000403040605010606010308
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The attached patch contains the x86_64 arch specific Makefile stuff.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------000403040605010606010308
Content-Type: text/plain;
 name="aes-arch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aes-arch.diff"

diff -rNu linux-2.6.11.2.orig/arch/x86_64/Makefile linux-2.6.11.2/arch/x86_64/Makefile
--- linux-2.6.11.2.orig/arch/x86_64/Makefile	2005-03-09 09:12:47.000000000 +0100
+++ linux-2.6.11.2/arch/x86_64/Makefile	2005-04-17 13:05:04.000000000 +0200
@@ -65,7 +65,8 @@
 head-y := arch/x86_64/kernel/head.o arch/x86_64/kernel/head64.o arch/x86_64/kernel/init_task.o
 
 libs-y 					+= arch/x86_64/lib/
-core-y					+= arch/x86_64/kernel/ arch/x86_64/mm/
+core-y					+= arch/x86_64/kernel/ arch/x86_64/mm/ \
+					   arch/x86_64/crypto/
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
 drivers-$(CONFIG_OPROFILE)		+= arch/x86_64/oprofile/
diff -rNu linux-2.6.11.2.orig/arch/x86_64/crypto/Makefile linux-2.6.11.2/arch/x86_64/crypto/Makefile
--- linux-2.6.11.2.orig/arch/x86_64/crypto/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11.2/arch/x86_64/crypto/Makefile	2005-04-17 13:02:00.000000000 +0200
@@ -0,0 +1,9 @@
+# 
+# x86_64/crypto/Makefile 
+# 
+# Arch-specific CryptoAPI modules.
+# 
+
+obj-$(CONFIG_CRYPTO_AES_X86_64) += aes-x86_64.o
+
+aes-x86_64-y := aes-x86_64-asm.o aes.o

--------------000403040605010606010308--
