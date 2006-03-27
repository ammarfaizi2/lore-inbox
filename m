Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWC0XEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWC0XEX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWC0XEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:04:23 -0500
Received: from xenotime.net ([66.160.160.81]:15029 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750909AbWC0XEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:04:22 -0500
Date: Mon, 27 Mar 2006 15:06:37 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: norsk5@xmission.com, dthompson@linuxnetworx.com
Cc: dsp@llnl.gov, dave_peterson@pobox.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: [PATCH] edac_752x needs CONFIG_HOTPLUG
Message-Id: <20060327150637.5aaf6493.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

EDAC_752X uses pci_scan_single_device(), which is only available
if CONFIG_HOTPLUG is enabled, so limit this driver with HOTPLUG.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/edac/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-g13.orig/drivers/edac/Kconfig
+++ linux-2616-g13/drivers/edac/Kconfig
@@ -71,7 +71,7 @@ config EDAC_E7XXX
 
 config EDAC_E752X
 	tristate "Intel e752x (e7520, e7525, e7320)"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on EDAC_MM_EDAC && PCI && X86 && HOTPLUG
 	help
 	  Support for error detection and correction on the Intel
 	  E7520, E7525, E7320 server chipsets.

---
