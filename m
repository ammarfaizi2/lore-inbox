Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263591AbUEMAAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUEMAAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 20:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbUEMAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 20:00:23 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:49158
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263591AbUEMAAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 20:00:08 -0400
Date: Wed, 12 May 2004 17:00:11 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [PATCH] Merge support for Keyspan UPR-112 USB serial adapter from 2.4 to 2.6
Message-ID: <20040513000011.GB9234@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Following patch merges the support for Keyspan UPR-112 USB serial adapter 
from 2.4 to 2.6.

Regards,

Tony

--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.6-usb-keyspan-upr-112"

This patch merges the support for Keyspan UPR-112 USB serial adapter 
from 2.4 to 2.6.

This patch contains updates to the following files:
   b/drivers/usb/serial/keyspan.h

diff -Nru a/drivers/usb/serial/keyspan.h b/drivers/usb/serial/keyspan.h
--- a/drivers/usb/serial/keyspan.h	Wed May 12 15:42:18 2004
+++ b/drivers/usb/serial/keyspan.h	Wed May 12 15:42:18 2004
@@ -326,6 +326,22 @@
 	.baudclk		= KEYSPAN_USA19_BAUDCLK,
 };
 
+static const struct keyspan_device_details mpr_device_details = {
+	.product_id		= keyspan_mpr_product_id,
+	.msg_format		= msg_usa28,
+	.num_ports		= 1,
+	.indat_endp_flip	= 1,
+	.outdat_endp_flip	= 1,
+	.indat_endpoints	= {0x81},
+	.outdat_endpoints	= {0x01},
+	.inack_endpoints	= {0x83},
+	.outcont_endpoints	= {0x03},
+	.instat_endpoint	= 0x84,
+	.glocont_endpoint	= -1,
+	.calculate_baud_rate	= keyspan_usa28_calc_baud,
+	.baudclk		= KEYSPAN_USA19_BAUDCLK,
+};
+
 static const struct keyspan_device_details usa19qw_device_details = {
 	.product_id		= keyspan_usa19qw_product_id,
 	.msg_format		= msg_usa26,
@@ -460,6 +476,7 @@
 	&usa18x_device_details,
 	&usa19_device_details,
 	&usa19qi_device_details,
+	&mpr_device_details,
 	&usa19qw_device_details,
 	&usa19w_device_details,
 	&usa19hs_device_details,
@@ -535,7 +552,7 @@
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19qw_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19w_product_id) },
 	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_usa19hs_product_id) },
-	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_mpr_pre_product_id) },
+	{ USB_DEVICE(KEYSPAN_VENDOR_ID, keyspan_mpr_product_id) },
 	{ } /* Terminating entry */
 };
 

--TakKZr9L6Hm6aLOc--
