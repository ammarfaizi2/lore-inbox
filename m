Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268543AbTANCuF>; Mon, 13 Jan 2003 21:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268542AbTANCts>; Mon, 13 Jan 2003 21:49:48 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50118 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268541AbTANCs6>;
	Mon, 13 Jan 2003 21:48:58 -0500
Message-Id: <200301140255.h0E2tku20743@w-gaughen.beaverton.ibm.com>
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] acpi compilation fix for 2.5.57
Date: Mon, 13 Jan 2003 18:55:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Stumbled upon two places that got missed when the typedefs in
the acpi code were removed.  Thought I'd pass the fix along. :-)

Thanks,
Pat

---
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

diff -Nru a/drivers/acpi/osl.c b/drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Mon Jan 13 18:50:39 2003
+++ b/drivers/acpi/osl.c	Mon Jan 13 18:50:39 2003
@@ -527,7 +527,7 @@
 
 acpi_status
 acpi_os_write_pci_configuration (
-	acpi_pci_id             *pci_id,
+	struct acpi_pci_id             *pci_id,
 	u32                     reg,
 	acpi_integer            value,
 	u32                     width)
@@ -537,7 +537,7 @@
 
 acpi_status
 acpi_os_read_pci_configuration (
-	acpi_pci_id             *pci_id,
+	struct acpi_pci_id             *pci_id,
 	u32                     reg,
 	void                    *value,
 	u32                     width)
