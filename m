Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUKWQb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUKWQb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUKWQ3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:29:41 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:30079 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261331AbUKWQOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:14:32 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123814.m1N7Tf2QmSCq9s5q@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:14:26 -0800
Message-Id: <20041123814.LeHMD5hRZLn6VbLm@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][3/21] Hook up drivers/infiniband
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:14:31.0771 (UTC) FILETIME=[83EA72B0:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate lines to drivers/Kconfig and drivers/Makefile so
that the kernel configuration and build systems know about drivers/infiniband.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/Kconfig	2004-11-23 08:09:54.858320443 -0800
+++ linux-bk/drivers/Kconfig	2004-11-23 08:10:17.410995118 -0800
@@ -54,4 +54,6 @@
 
 source "drivers/usb/Kconfig"
 
+source "drivers/infiniband/Kconfig"
+
 endmenu
--- linux-bk.orig/drivers/Makefile	2004-11-23 08:10:06.504603238 -0800
+++ linux-bk/drivers/Makefile	2004-11-23 08:10:17.411994971 -0800
@@ -59,4 +59,5 @@
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
+obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/

