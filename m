Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbUKVQUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbUKVQUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUKVQTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:19:18 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:47299 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261537AbUKVPNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:13:42 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041122713.TMt4584EVSreQOO2@topspin.com>
X-Mailer: roland_patchbomb
Date: Mon, 22 Nov 2004 07:13:36 -0800
Message-Id: <20041122713.yCm1WiU1XOAxLOWd@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v1][2/12] Hook up drivers/infiniband
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 15:13:41.0524 (UTC) FILETIME=[D9C93540:01C4D0A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate lines to drivers/Kconfig and drivers/Makefile so
that the kernel configuration and build systems know about drivers/infiniband.

Signed-off-by: Roland Dreier <roland@topspin.com>


Index: linux-bk/drivers/Kconfig
===================================================================
--- linux-bk.orig/drivers/Kconfig	2004-11-21 21:07:30.646934807 -0800
+++ linux-bk/drivers/Kconfig	2004-11-21 21:25:52.850360262 -0800
@@ -54,4 +54,6 @@
 
 source "drivers/usb/Kconfig"
 
+source "drivers/infiniband/Kconfig"
+
 endmenu
Index: linux-bk/drivers/Makefile
===================================================================
--- linux-bk.orig/drivers/Makefile	2004-11-21 21:07:54.491393897 -0800
+++ linux-bk/drivers/Makefile	2004-11-21 21:25:52.850360262 -0800
@@ -59,4 +59,5 @@
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
+obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/

