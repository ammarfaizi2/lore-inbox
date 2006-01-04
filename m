Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWADWAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWADWAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWADWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:00:13 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:22259 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030334AbWADWAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:00:10 -0500
Date: Wed, 04 Jan 2006 16:59:44 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 04/15] i386: Handle HP laptop rebooting properly.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL004R0943MT@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 arch/i386/kernel/reboot.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

2e513fcd2a64eae5d7d9937ca253760d249d10a5
diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
index 2afe0f8..cba9057 100644
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -111,6 +111,14 @@ static struct dmi_system_id __initdata r
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 		},
 	},
+	{	/* HP laptops have weird reboot issues */
+		.callback = set_bios_reboot,
+		.ident = "HP Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
+		},
+	},
 	{	/* Handle problems with rebooting on HP nc6120 */
 		.callback = set_bios_reboot,
 		.ident = "HP Compaq nc6120",
-- 
1.0.5
