Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUCCEh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUCCEfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:35:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:41090 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262374AbUCCEWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:06 -0500
Subject: Re: [PATCH] PCI Hotplug fixes for 2.6.4-rc1
In-Reply-To: <10782877061393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:21:46 -0800
Message-Id: <10782877061347@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1625, 2004/03/02 19:25:34-08:00, greg@kroah.com

PCI Hotplug: clean up the Makefile a bit more.


 drivers/pci/hotplug/Makefile |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)


diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Tue Mar  2 19:42:02 2004
+++ b/drivers/pci/hotplug/Makefile	Tue Mar  2 19:42:02 2004
@@ -50,13 +50,10 @@
 				pciehp_pci.o	\
 				pciehp_sysfs.o	\
 				pciehp_hpc.o
-
-ifdef CONFIG_HOTPLUG_PCI_PCIE
-  ifdef CONFIG_ACPI_BUS
-    pciehp-objs += pciehprm_acpi.o
-  else
-    pciehp-objs += pciehprm_nonacpi.o
-  endif
+ifdef CONFIG_ACPI_BUS
+	pciehp-objs += pciehprm_acpi.o
+else
+	pciehp-objs += pciehprm_nonacpi.o
 endif
 
 shpchp-objs		:=	shpchp_core.o	\
@@ -64,15 +61,12 @@
 				shpchp_pci.o	\
 				shpchp_sysfs.o	\
 				shpchp_hpc.o
-
-ifdef CONFIG_HOTPLUG_PCI_SHPC
-  ifdef CONFIG_ACPI_BUS
-    shpchp-objs += shpchprm_acpi.o
-  else
-    ifdef CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY
-      shpchp-objs += shpchprm_legacy.o
-    else
-      shpchp-objs += shpchprm_nonacpi.o
-    endif
-  endif
+ifdef CONFIG_ACPI_BUS
+	shpchp-objs += shpchprm_acpi.o
+else
+	ifdef CONFIG_HOTPLUG_PCI_SHPC_PHPRM_LEGACY
+		shpchp-objs += shpchprm_legacy.o
+	else
+		shpchp-objs += shpchprm_nonacpi.o
+	endif
 endif

