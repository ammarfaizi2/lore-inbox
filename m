Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWHHNo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWHHNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWHHNo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:44:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:4458 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932570AbWHHNo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:44:28 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,221,1151910000"; 
   d="scan'208"; a="104830438:sNHT16884014"
Date: Tue, 8 Aug 2006 09:44:26 -0400
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [patch] pciehp: make pciehp build for powerpc
Message-Id: <20060808094426.daa00777.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make pciehp build on powerpc

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Acked-by: Randy Dunlap <rdunlap@xenotime.net>

---
 drivers/pci/hotplug/pciehp.h     |    5 +++++
 drivers/pci/hotplug/pciehp_hpc.c |    4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

--- 2.6-git.orig/drivers/pci/hotplug/pciehp.h
+++ 2.6-git/drivers/pci/hotplug/pciehp.h
@@ -279,6 +279,11 @@ struct hpc_ops {
 
 
 #ifdef CONFIG_ACPI
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/actypes.h>
+#include <linux/pci-acpi.h>
+
 #define pciehp_get_hp_hw_control_from_firmware(dev) \
 	pciehp_acpi_get_hp_hw_control_from_firmware(dev)
 static inline int pciehp_get_hp_params_from_firmware(struct pci_dev *dev,
--- 2.6-git.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ 2.6-git/drivers/pci/hotplug/pciehp_hpc.c
@@ -38,10 +38,6 @@
 
 #include "../pci.h"
 #include "pciehp.h"
-#include <acpi/acpi.h>
-#include <acpi/acpi_bus.h>
-#include <acpi/actypes.h>
-#include <linux/pci-acpi.h>
 #ifdef DEBUG
 #define DBG_K_TRACE_ENTRY      ((unsigned int)0x00000001)	/* On function entry */
 #define DBG_K_TRACE_EXIT       ((unsigned int)0x00000002)	/* On function exit */
