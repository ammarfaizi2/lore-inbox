Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbULTG1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbULTG1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 01:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbULTG1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 01:27:35 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:6069 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261428AbULTGOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:14:55 -0500
Cc: openib-general@openib.org
In-Reply-To: <200412192214.uWyITZT30vxqMJuO@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 19 Dec 2004 22:14:53 -0800
Message-Id: <200412192214.qTsUPCeCMCi5dvjR@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v4][3/24] Hook up drivers/infiniband
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 20 Dec 2004 06:14:53.0598 (UTC) FILETIME=[38682BE0:01C4E65B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate lines to drivers/Kconfig and drivers/Makefile so
that the kernel configuration and build systems know about drivers/infiniband.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/Kconfig	2004-12-19 21:09:51.000000000 -0800
+++ linux-bk/drivers/Kconfig	2004-12-19 22:04:12.806811886 -0800
@@ -54,4 +54,6 @@
 
 source "drivers/usb/Kconfig"
 
+source "drivers/infiniband/Kconfig"
+
 endmenu
--- linux-bk.orig/drivers/Makefile	2004-12-19 21:10:06.000000000 -0800
+++ linux-bk/drivers/Makefile	2004-12-19 22:04:12.806811886 -0800
@@ -59,4 +59,5 @@
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
+obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/

