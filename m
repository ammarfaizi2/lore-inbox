Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVJQNKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVJQNKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 09:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVJQNKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 09:10:15 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:45872 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751237AbVJQNKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 09:10:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qPE6+89VSusHuiHoG9f00HTJf8U3kna56VCx6pjSjMYxuPcaZxgsf4iFUXxpqz3c5AynIUlrhxSFa2Up0YvSS3JiRqoDduW85AORBOnrFbB/R808++xCVh4ar8OrdMmvtKxoCOdK8i254FlQPEN9MubuJFbmla/gtM0LsBbD2ck=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Bluesmoke is now EDAC
Date: Mon, 17 Oct 2005 15:13:16 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171513.16597.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this sub-system was deliberately renamed from Bluesmoke to EDAC. In
that case, we should probably get rid of the remaining Bluesmoke references
and change them into EDAC.

This patch changes Bluesmoke into EDAC in Kconfig and Makefile and I also took
the liberty of rewriting some of the help text slightly.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/edac/Kconfig  |   19 +++++++++----------
 drivers/edac/Makefile |    2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

--- linux-2.6.14-rc4-mm1-orig/drivers/edac/Kconfig	2005-10-17 15:08:56.000000000 +0200
+++ linux-2.6.14-rc4-mm1/drivers/edac/Kconfig	2005-10-17 15:08:16.000000000 +0200
@@ -15,8 +15,8 @@
 	  EDAC is designed to report errors in the core system.
 	  These are low-level errors that are reported in the CPU or
 	  supporting chipset: memory errors, cache errors, PCI errors,
-	  thermal throttling, etc..  If unsure, select 'Y'.
-
+	  thermal throttling, etc.
+	  If unsure, select 'Y'.
 
 comment "Reporting subsystems"
 	depends on EDAC
@@ -26,8 +26,8 @@
 	depends on EDAC
 	help
 	  This turns on debugging information for the entire EDAC
-	  sub-system. You can insert module with "debug_level=x", current
-	  there're four debug levels (x=0,1,2,3 from low to high).
+	  sub-system. You can insert module with "debug_level=x", currently
+	  there are four debug levels (x=0,1,2,3 from low to high).
 	  Usually you should select 'N'.
 
 config EDAC_MM_EDAC
@@ -35,12 +35,11 @@
 	depends on EDAC
 	help
 	  Some systems are able to detect and correct errors in main
-	  memory.  Bluesmoke can report statistics on memory error
-	  detection and correction (EDAC - or commonly referred to ECC
-	  errors).  Bluesmoke will also try to decode where these errors
-	  occurred so that a particular failing memory module can be
-	  replaced.  If unsure, select 'Y'.
-
+	  memory.  EDAC can report statistics on memory error detection
+	  and correction (commonly referred to ECC errors).
+	  EDAC will also try to decode where these errors occurred so
+	  that a particular failing memory module can be replaced.
+	  If unsure, select 'Y'.
 
 config EDAC_AMD76X
 	tristate "AMD 76x (760, 762, 768)"
--- linux-2.6.14-rc4-mm1-orig/drivers/edac/Makefile	2005-10-17 12:00:36.000000000 +0200
+++ linux-2.6.14-rc4-mm1/drivers/edac/Makefile	2005-10-17 15:03:49.000000000 +0200
@@ -1,5 +1,5 @@
 #
-# Makefile for the Linux kernel bluesmoke drivers.
+# Makefile for the Linux kernel EDAC drivers.
 #
 # Copyright 02 Jul 2003, Linux Networx (http://lnxi.com)
 # This file may be distributed under the terms of the



