Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbUL1GBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUL1GBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 01:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbUL1GBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 01:01:42 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:52561 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262064AbUL1Fxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:53:41 -0500
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       openib-general@openib.org
In-Reply-To: <200412272150.vKuRYXlCFl5x8NAo@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Mon, 27 Dec 2004 21:50:55 -0800
Message-Id: <200412272150.BzlME8aULSGdgnS3@topspin.com>
Mime-Version: 1.0
To: davem@davemloft.net
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v5][3/24] Hook up drivers/infiniband
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Dec 2004 05:50:56.0829 (UTC) FILETIME=[33549ED0:01C4ECA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate lines to drivers/Kconfig and drivers/Makefile so
that the kernel configuration and build systems know about drivers/infiniband.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/Kconfig	2004-12-27 21:47:59.198084242 -0800
+++ linux-bk/drivers/Kconfig	2004-12-27 21:48:19.194140917 -0800
@@ -56,4 +56,6 @@
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/infiniband/Kconfig"
+
 endmenu
--- linux-bk.orig/drivers/Makefile	2004-12-27 21:48:10.314447971 -0800
+++ linux-bk/drivers/Makefile	2004-12-27 21:48:19.194140917 -0800
@@ -59,5 +59,6 @@
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
+obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/

