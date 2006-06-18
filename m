Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWFRHgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWFRHgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWFRHgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:36:07 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:26602 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932162AbWFRHfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:35:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][29/29] kconfig-expose_vmsplit_option.patch
Date: Sun, 18 Jun 2006 17:35:43 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1986
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181735.44232.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The options to alter the vmsplit to enable more lowmem are hidden behind the
embedded option. Make it more exposed for -ck users and make the help menu
more explicit about what each option means.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 arch/i386/Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-ck-dev/arch/i386/Kconfig
===================================================================
--- linux-ck-dev.orig/arch/i386/Kconfig	2006-06-18 15:20:10.000000000 +1000
+++ linux-ck-dev/arch/i386/Kconfig	2006-06-18 15:26:41.000000000 +1000
@@ -467,7 +467,7 @@ endchoice
 
 choice
 	depends on EXPERIMENTAL && !X86_PAE
-	prompt "Memory split" if EMBEDDED
+	prompt "Memory split"
 	default VMSPLIT_3G
 	help
 	  Select the desired split between kernel and user memory.
@@ -486,13 +486,13 @@ choice
 	  option alone!
 
 	config VMSPLIT_3G
-		bool "3G/1G user/kernel split"
+		bool "Default 896MB lowmem (3G/1G user/kernel split)"
 	config VMSPLIT_3G_OPT
-		bool "3G/1G user/kernel split (for full 1G low memory)"
+		bool "1GB lowmem (3G/1G user/kernel split)"
 	config VMSPLIT_2G
-		bool "2G/2G user/kernel split"
+		bool "2GB lowmem (2G/2G user/kernel split)"
 	config VMSPLIT_1G
-		bool "1G/3G user/kernel split"
+		bool "3GB lowmem (1G/3G user/kernel split)"
 endchoice
 
 config PAGE_OFFSET

-- 
-ck
