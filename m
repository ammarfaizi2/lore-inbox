Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbVIBVQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbVIBVQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbVIBVQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:16:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18699 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161037AbVIBVQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:16:58 -0400
Date: Fri, 2 Sep 2005 23:16:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch] drivers/acpi/: make needlessly global functions static
Message-ID: <20050902211648.GW3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlesly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/osl.c            |    2 +-
 drivers/acpi/pci_bind.c       |    3 ++-
 drivers/acpi/processor_core.c |    2 +-
 drivers/acpi/scan.c           |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.13-mm1-full/drivers/acpi/osl.c.old	2005-09-02 22:54:33.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/acpi/osl.c	2005-09-02 22:54:46.000000000 +0200
@@ -1038,7 +1038,7 @@
 
 __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
 
-int __init acpi_hotkey_setup(char *str)
+static int __init acpi_hotkey_setup(char *str)
 {
 	acpi_specific_hotkey_enabled = FALSE;
 	return 1;
--- linux-2.6.13-mm1-full/drivers/acpi/pci_bind.c.old	2005-09-02 22:57:23.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/acpi/pci_bind.c	2005-09-02 22:57:45.000000000 +0200
@@ -44,7 +44,8 @@
 	struct pci_dev *dev;
 };
 
-void acpi_pci_data_handler(acpi_handle handle, u32 function, void *context)
+static void acpi_pci_data_handler(acpi_handle handle, u32 function,
+				  void *context)
 {
 	ACPI_FUNCTION_TRACE("acpi_pci_data_handler");
 
--- linux-2.6.13-mm1-full/drivers/acpi/processor_core.c.old	2005-09-02 22:59:06.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/acpi/processor_core.c	2005-09-02 22:59:18.000000000 +0200
@@ -221,7 +221,7 @@
 	return_VALUE(0);
 }
 
-int acpi_processor_errata(struct acpi_processor *pr)
+static int acpi_processor_errata(struct acpi_processor *pr)
 {
 	int result = 0;
 	struct pci_dev *dev = NULL;
--- linux-2.6.13-mm1-full/drivers/acpi/scan.c.old	2005-09-02 22:59:48.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/acpi/scan.c	2005-09-02 23:00:02.000000000 +0200
@@ -527,7 +527,7 @@
 	return_VALUE(0);
 }
 
-int acpi_start_single_object(struct acpi_device *device)
+static int acpi_start_single_object(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_driver *driver;

