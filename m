Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbULMSVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbULMSVr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 13:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbULMSVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 13:21:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:26680 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261306AbULMSJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:09:25 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041213109.B80JuEFdg6Nma7kr@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 13 Dec 2004 10:09:23 -0800
Message-Id: <20041213109.GUz9r6Ey44wtDeiY@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v3][3/21] Hook up drivers/infiniband
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 13 Dec 2004 18:09:23.0927 (UTC) FILETIME=[E038FE70:01C4E13E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate lines to drivers/Kconfig and drivers/Makefile so
that the kernel configuration and build systems know about drivers/infiniband.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/Kconfig	2004-12-11 15:16:34.000000000 -0800
+++ linux-bk/drivers/Kconfig	2004-12-13 09:44:41.933547814 -0800
@@ -54,4 +54,6 @@
 
 source "drivers/usb/Kconfig"
 
+source "drivers/infiniband/Kconfig"
+
 endmenu
--- linux-bk.orig/drivers/Makefile	2004-12-11 15:16:49.000000000 -0800
+++ linux-bk/drivers/Makefile	2004-12-13 09:44:41.953544868 -0800
@@ -59,4 +59,5 @@
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
+obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/

