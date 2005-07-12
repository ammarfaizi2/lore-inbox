Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVGLTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVGLTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVGLTvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:51:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48903 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262314AbVGLTvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:51:24 -0400
Date: Tue, 12 Jul 2005 21:51:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] enable ACPI_HOTPLUG_CPU automatically if HOTPLUG_CPU=y
Message-ID: <20050712195120.GH4034@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the combination
- HOTPLUG_CPU=y
- ACPI_PROCESSOR=y
- ACPI_HOTPLUG_CPU=n
make any sense?


If not, please apply this patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc2-mm2-full/drivers/acpi/Kconfig.old	2005-07-12 21:45:41.000000000 +0200
+++ linux-2.6.13-rc2-mm2-full/drivers/acpi/Kconfig	2005-07-12 21:46:04.000000000 +0200
@@ -153,12 +153,10 @@
 	  support it.
 
 config ACPI_HOTPLUG_CPU
-	bool "Processor Hotplug (EXPERIMENTAL)"
-	depends on ACPI_PROCESSOR && HOTPLUG_CPU && EXPERIMENTAL
+	bool
+	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
-	default n
-	 ---help---
-	 Select this option if your platform support physical CPU hotplug.
+	default y
 
 config ACPI_THERMAL
 	tristate "Thermal Zone"

