Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVAXGUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVAXGUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVAXGUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:20:07 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:19986 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261450AbVAXGO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:14:27 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][4/12] InfiniBand/core: fix port capability enums bit order
In-Reply-To: <20051232214.v4gD7pRb7UQo64yW@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Sun, 23 Jan 2005 22:14:23 -0800
Message-Id: <20051232214.1JLCX02EnyVBhKBe@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jan 2005 06:14:25.0122 (UTC) FILETIME=[F3E45420:01C501DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct defines of port capability mask enum values (bits were ordered
backwards) and add new capability bits from IBA spec version 1.2.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/include/ib_verbs.h	2005-01-23 08:30:22.000000000 -0800
+++ linux-bk/drivers/infiniband/include/ib_verbs.h	2005-01-23 20:46:23.606432952 -0800
@@ -154,25 +154,28 @@
 };
 
 enum ib_port_cap_flags {
-	IB_PORT_SM				= (1<<31),
-	IB_PORT_NOTICE_SUP			= (1<<30),
-	IB_PORT_TRAP_SUP			= (1<<29),
-	IB_PORT_AUTO_MIGR_SUP			= (1<<27),
-	IB_PORT_SL_MAP_SUP			= (1<<26),
-	IB_PORT_MKEY_NVRAM			= (1<<25),
-	IB_PORT_PKEY_NVRAM			= (1<<24),
-	IB_PORT_LED_INFO_SUP			= (1<<23),
-	IB_PORT_SM_DISABLED			= (1<<22),
-	IB_PORT_SYS_IMAGE_GUID_SUP		= (1<<21),
-	IB_PORT_PKEY_SW_EXT_PORT_TRAP_SUP	= (1<<20),
-	IB_PORT_CM_SUP				= (1<<16),
-	IB_PORT_SNMP_TUNNEL_SUP			= (1<<15),
-	IB_PORT_REINIT_SUP			= (1<<14),
-	IB_PORT_DEVICE_MGMT_SUP			= (1<<13),
-	IB_PORT_VENDOR_CLASS_SUP		= (1<<12),
-	IB_PORT_DR_NOTICE_SUP			= (1<<11),
-	IB_PORT_PORT_NOTICE_SUP			= (1<<10),
-	IB_PORT_BOOT_MGMT_SUP			= (1<<9)
+	IB_PORT_SM				= 1 <<  1,
+	IB_PORT_NOTICE_SUP			= 1 <<  2,
+	IB_PORT_TRAP_SUP			= 1 <<  3,
+	IB_PORT_OPT_IPD_SUP                     = 1 <<  4,
+	IB_PORT_AUTO_MIGR_SUP			= 1 <<  5,
+	IB_PORT_SL_MAP_SUP			= 1 <<  6,
+	IB_PORT_MKEY_NVRAM			= 1 <<  7,
+	IB_PORT_PKEY_NVRAM			= 1 <<  8,
+	IB_PORT_LED_INFO_SUP			= 1 <<  9,
+	IB_PORT_SM_DISABLED			= 1 << 10,
+	IB_PORT_SYS_IMAGE_GUID_SUP		= 1 << 11,
+	IB_PORT_PKEY_SW_EXT_PORT_TRAP_SUP	= 1 << 12,
+	IB_PORT_CM_SUP				= 1 << 16,
+	IB_PORT_SNMP_TUNNEL_SUP			= 1 << 17,
+	IB_PORT_REINIT_SUP			= 1 << 18,
+	IB_PORT_DEVICE_MGMT_SUP			= 1 << 19,
+	IB_PORT_VENDOR_CLASS_SUP		= 1 << 20,
+	IB_PORT_DR_NOTICE_SUP			= 1 << 21,
+	IB_PORT_CAP_MASK_NOTICE_SUP		= 1 << 22,
+	IB_PORT_BOOT_MGMT_SUP			= 1 << 23,
+	IB_PORT_LINK_LATENCY_SUP		= 1 << 24,
+	IB_PORT_CLIENT_REG_SUP			= 1 << 25
 };
 
 enum ib_port_width {

