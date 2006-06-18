Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWFRHdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWFRHdR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWFRHdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:33:16 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:49129 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932149AbWFRHc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:32:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][15/29] hz-no_default_250.patch
Date: Sun, 18 Jun 2006 17:32:48 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2073
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181732.48952.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make 250 HZ a value that is not selected by default and give some better
recommendations in help.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/Kconfig.hz |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

Index: linux-ck-dev/kernel/Kconfig.hz
===================================================================
--- linux-ck-dev.orig/kernel/Kconfig.hz	2006-06-18 15:23:58.000000000 +1000
+++ linux-ck-dev/kernel/Kconfig.hz	2006-06-18 15:24:28.000000000 +1000
@@ -21,14 +21,17 @@ choice
 	help
 	  100 HZ is a typical choice for servers, SMP and NUMA systems
 	  with lots of processors that may show reduced performance if
-	  too many timer interrupts are occurring.
+	  too many timer interrupts are occurring. Laptops may also show
+	  improved battery life.
 
-	config HZ_250
+	config HZ_250_NODEFAULT
 		bool "250 HZ"
 	help
-	 250 HZ is a good compromise choice allowing server performance
-	 while also showing good interactive responsiveness even
-	 on SMP and NUMA systems.
+	 250 HZ is a lousy compromise choice allowing server interactivity
+	 while also showing desktop throughput and no extra power saving on
+	 laptops. Good for when you can't make up your mind.
+
+	 Recommend 100 or 1000 instead.
 
 	config HZ_1000
 		bool "1000 HZ"
@@ -41,6 +44,6 @@ endchoice
 config HZ
 	int
 	default 100 if HZ_100
-	default 250 if HZ_250
+	default 250 if HZ_250_NODEFAULT
 	default 1000 if HZ_1000
 

-- 
-ck
