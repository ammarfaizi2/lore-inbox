Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWADV7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWADV7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWADV7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:59:41 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:43249 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030292AbWADV7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:59:40 -0500
Date: Wed, 04 Jan 2006 16:59:12 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 01/15] i386/acpi: Disable ACPI-PCI for Toshiba Tecra A4
 laptops, bios ver 1.60.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00E2A933UV@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reference: http://bugzilla.ubuntu.com/17398

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 arch/i386/kernel/acpi/boot.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

ef75d4e664e162516e5b3ed93aa959c3e10da4ba
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 447fa9e..9d3dc8c 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -1053,6 +1053,15 @@ static struct dmi_system_id __initdata a
 		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		     },
 	 },
+	{
+	 .callback = disable_acpi_pci,
+	 .ident = "Toshiba Tecra A4",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "TECRA A4"),
+		     DMI_MATCH(DMI_BIOS_VERSION, "Version 1.60"),
+		     },
+	 },
 	{}
 };
 
-- 
1.0.5
