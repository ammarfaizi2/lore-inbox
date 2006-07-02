Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWGBXF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWGBXF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWGBXF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:05:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9174 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751477AbWGBXF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:05:58 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:05:43 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 08/19] ieee1394: remove redundant code from ieee1394_hotplug.h
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.09e5be849fcb5c6e@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.924) AWL,BAYES_50,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ieee1394_hotplug.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_hotplug.h	2006-07-01 17:42:38.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_hotplug.h	2006-07-01 17:49:43.000000000 +0200
@@ -1,32 +1,19 @@
 #ifndef _IEEE1394_HOTPLUG_H
 #define _IEEE1394_HOTPLUG_H
 
-#include <linux/mod_devicetable.h>
-#include <linux/types.h>
-
 /* Unit spec id and sw version entry for some protocols */
 #define AVC_UNIT_SPEC_ID_ENTRY		0x0000A02D
 #define AVC_SW_VERSION_ENTRY		0x00010001
 #define CAMERA_UNIT_SPEC_ID_ENTRY	0x0000A02D
 #define CAMERA_SW_VERSION_ENTRY		0x00000100
 
-/* Check to make sure this all isn't already defined */
-#ifndef IEEE1394_MATCH_VENDOR_ID
-
-#define IEEE1394_MATCH_VENDOR_ID	0x0001
-#define IEEE1394_MATCH_MODEL_ID		0x0002
-#define IEEE1394_MATCH_SPECIFIER_ID	0x0004
-#define IEEE1394_MATCH_VERSION		0x0008
-
-struct ieee1394_device_id {
-	u32 match_flags;
-	u32 vendor_id;
-	u32 model_id;
-	u32 specifier_id;
-	u32 version;
-	void *driver_data;
-};
-
-#endif
+/* /include/linux/mod_devicetable.h defines:
+ *	IEEE1394_MATCH_VENDOR_ID
+ *	IEEE1394_MATCH_MODEL_ID
+ *	IEEE1394_MATCH_SPECIFIER_ID
+ *	IEEE1394_MATCH_VERSION
+ *	struct ieee1394_device_id
+ */
+#include <linux/mod_devicetable.h>
 
 #endif /* _IEEE1394_HOTPLUG_H */


