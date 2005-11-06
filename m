Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVKFApL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVKFApL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKFApL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:45:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5645 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932249AbVKFApK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:45:10 -0500
Date: Sun, 6 Nov 2005 01:45:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] drivers/pci/: small cleanups
Message-ID: <20051106004508.GC3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- access.c should #include "pci.h" for getting the prototypes of it's
  global functions
- hotplug/shpchp_pci.c: make the needlessly global function
  program_fw_provided_values() static


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/access.c             |    2 ++
 drivers/pci/hotplug/shpchp_pci.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.14-rc5-mm1-full/drivers/pci/access.c.old	2005-11-06 00:26:26.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/pci/access.c	2005-11-06 00:26:54.000000000 +0100
@@ -2,6 +2,8 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 
+#include "pci.h"
+
 /*
  * This interrupt-safe spinlock protects all accesses to PCI
  * configuration space.
--- linux-2.6.14-rc5-mm1-full/drivers/pci/hotplug/shpchp_pci.c.old	2005-11-06 00:28:10.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/pci/hotplug/shpchp_pci.c	2005-11-06 00:28:17.000000000 +0100
@@ -34,7 +34,7 @@
 #include "../pci.h"
 #include "shpchp.h"
 
-void program_fw_provided_values(struct pci_dev *dev)
+static void program_fw_provided_values(struct pci_dev *dev)
 {
 	u16 pci_cmd, pci_bctl;
 	struct pci_dev *cdev;

