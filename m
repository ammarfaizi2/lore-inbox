Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbQLVLfF>; Fri, 22 Dec 2000 06:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbQLVLeq>; Fri, 22 Dec 2000 06:34:46 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:55563 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S131495AbQLVLeh>;
	Fri, 22 Dec 2000 06:34:37 -0500
Date: Fri, 22 Dec 2000 12:03:21 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200012221103.MAA08412@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: usb id for scanner epson 1640SU Photo
Cc: khk@khk.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Here are the patches for scanner.h (kernels 2.2) and scanner.c (kernels 2.4) to
add the IDs (Vendor, Model) for an usb scanner Epson Perfection 1640SU Photo (or
vanilla 1640SU as the "Photo" is an extension).
This was done with the advice of Karl Heinz Kremer <khk@khk.net>
I think they can be applied withut adverse problems

--- kernel-sources-2.2.19-pre3/drivers/usb/scanner.h	Fri Dec 22 09:03:23 2000
+++ f5ibh-kernel-2.2.19pre/drivers/usb/scanner.h	Fri Dec 22 09:02:56 2000
@@ -151,6 +151,7 @@
 		{ 0x04b8, 0x0101 },	/* Perfection 636U and 636Photo */
 		{ 0x04b8, 0x0103 },	/* Perfection 610 */
 		{ 0x04b8, 0x0104 },	/* Perfection 1200U and 1200Photo */
+		{ 0x04b8, 0x010a },	/* Perfection 1640SU Photo */
 	/* Umax */
 		{ 0x1606, 0x0010 },	/* Astra 1220U */
 		{ 0x1606, 0x0002 },	/* Astra 1236U */

		
--- kernel-sources-2.4.0-test13-pre4/drivers/usb/scanner.c	Fri Dec 22 08:58:32 2000
+++ f5ibh-kernel-2.4.0/drivers/usb/scanner.c	Fri Dec 22 08:56:58 2000
@@ -303,6 +303,7 @@
     { idVendor: 0x04b8, idProduct: 0x0104 },/* Perfection 1200U and 1200Photo*/
     { idVendor: 0x04b8, idProduct: 0x0106 },/* Stylus Scan 2500 */
     { idVendor: 0x04b8, idProduct: 0x0107 },/* Expression 1600 */
+    { idVendor: 0x04b8, idProduct: 0x010a },/* Perfection 1640SU Photo */
 	/* Umax */
     { idVendor: 0x1606, idProduct: 0x0010 },	/* Astra 1220U */
     { idVendor: 0x1606, idProduct: 0x0030 },	/* Astra 2000U */

-------------
Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
