Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVKKDPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVKKDPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVKKDPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:15:55 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:65179 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932326AbVKKDPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:15:54 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: [PATCH] plugsched - update Kconfig-1
Date: Fri, 11 Nov 2005 14:17:03 +1100
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <434F01EA.6060709@bigpond.net.au> <200511111405.33762.kernel@kolivas.org>
In-Reply-To: <200511111405.33762.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v0AdDATVtXKZLo6"
Message-Id: <200511111417.03859.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_v0AdDATVtXKZLo6
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a respin just changing the spa menu.

Cheers,
Con

--Boundary-00=_v0AdDATVtXKZLo6
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="plugsched-6.1.3-update-Kconfig-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="plugsched-6.1.3-update-Kconfig-1.patch"

Make a submenu for spa schedulers instead of having a flat list.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Kconfig |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

Index: linux-2.6.14-plugsched/init/Kconfig
===================================================================
--- linux-2.6.14-plugsched.orig/init/Kconfig	2005-11-11 14:12:12.000000000 +1100
+++ linux-2.6.14-plugsched/init/Kconfig	2005-11-11 14:13:26.000000000 +1100
@@ -358,7 +358,7 @@ config CPUSCHED_STAIRCASE
 	  To boot this cpu scheduler, if it is not the default, use the
 	  bootparam "cpusched=staircase".
 
-config CPUSCHED_SPA
+menuconfig CPUSCHED_SPA
 	bool "SPA cpu schedulers" if EMBEDDED
 	depends on PLUGSCHED
 	default y
@@ -366,9 +366,7 @@ config CPUSCHED_SPA
 	  Support for O(1) single priority array schedulers.
 
 config CPUSCHED_SPA_NF
-	bool "SPA cpu scheduler (no frills)" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "SPA cpu scheduler (no frills)" if CPUSCHED_SPA
 	default y
 	---help---
 	  This scheduler is a simple round robin O(1) single priority array
@@ -379,9 +377,7 @@ config CPUSCHED_SPA_NF
 	  bootparam "cpusched=spa_no_frills".
 
 config CPUSCHED_SPA_WS
-	bool "SPA cpu scheduler (work station)" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "SPA cpu scheduler (work station)" if CPUSCHED_SPA
 	default y
 	---help---
 	  This is a scheduler with a O(1) single priority array intended for
@@ -391,9 +387,7 @@ config CPUSCHED_SPA_WS
 	  bootparam "cpusched=spa_ws".
 
 config CPUSCHED_SPA_SVR
-	bool "SPA cpu scheduler (server)" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "SPA cpu scheduler (server)" if CPUSCHED_SPA
 	default y
 	---help---
 	  This is a scheduler with a O(1) single priority array intended for
@@ -403,9 +397,7 @@ config CPUSCHED_SPA_SVR
 	  bootparam "cpusched=spa_svr".
 
 config CPUSCHED_ZAPHOD
-	bool "Zaphod cpu scheduler" if EMBEDDED
-	depends on PLUGSCHED
-	select CPUSCHED_SPA
+	bool "Zaphod cpu scheduler" if CPUSCHED_SPA
 	default y
 	---help---
 	  This scheduler is an O(1) single priority array with interactive

--Boundary-00=_v0AdDATVtXKZLo6--
