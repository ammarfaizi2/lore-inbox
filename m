Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUETDuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUETDuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 23:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264863AbUETDuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 23:50:16 -0400
Received: from provone.provsol.net ([66.83.239.66]:48572 "EHLO
	provone.provsol.net") by vger.kernel.org with ESMTP id S264860AbUETDuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 23:50:06 -0400
Message-ID: <40AC2AE9.5070004@provident-solutions.com>
Date: Wed, 19 May 2004 22:50:01 -0500
From: "Vernon A. Fort" <vfort@provident-solutions.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] mxser.c kernel-2.6.5
Content-Type: multipart/mixed;
 boundary="------------090908010301010804070007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090908010301010804070007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for the CP-104 Moxa Smartio serial cards - 
fairly stright forward modification.

Attached is a short patch.  Please CC me if any concerns or questions, 
I'm not a subscribed member.

Thanks

Vernon Fort
Provident Solutions, LLC
(615) 427-4016

--------------090908010301010804070007
Content-Type: text/plain;
 name="mxser.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mxser.diff"

--- linux-2.6.5/drivers/char/mxser.c	2004-05-19 22:17:16.000000000 -0500
+++ linux/drivers/char/mxser.c	2004-05-19 22:42:58.000000000 -0500
@@ -35,6 +35,8 @@
  *    Added support for: C102, CI-132, CI-134, CP-132, CP-114, CT-114 cards
  *                        by Damian Wrobel <dwrobel@ertel.com.pl>
  *
+ *    Added support for serial card CP104
+ *			  by James Nelson Provident Solutions <linux-info@provident-solutions.com>
  */
 
 #include <linux/config.h>
@@ -116,6 +118,9 @@
 #ifndef PCI_DEVICE_ID_C104
 #define PCI_DEVICE_ID_C104	0x1040
 #endif
+#ifndef PCI_DEVICE_ID_CP104
+#define PCI_DEVICE_ID_CP104	0x1041
+#endif
 #ifndef PCI_DEVICE_ID_CP132
 #define PCI_DEVICE_ID_CP132	0x1320
 #endif
@@ -139,6 +144,7 @@
 	MXSER_BOARD_CI104J,
 	MXSER_BOARD_C168_PCI,
 	MXSER_BOARD_C104_PCI,
+	MXSER_BOARD_CP104_PCI,
 	MXSER_BOARD_C102_ISA,
 	MXSER_BOARD_CI132,
 	MXSER_BOARD_CI134,
@@ -154,6 +160,7 @@
 	"CI-104J series",
 	"C168H/PCI series",
 	"C104H/PCI series",
+	"CP104/PCI series",
 	"C102 series",
 	"CI-132 series",
 	"CI-134 series",
@@ -169,6 +176,7 @@
 	4,
 	8,
 	4,
+	4,
 	2,
 	2,
 	4,
@@ -195,6 +203,8 @@
 	  MXSER_BOARD_C168_PCI },
 	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 	  MXSER_BOARD_C104_PCI },
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+	  MXSER_BOARD_CP104_PCI },
 	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP132, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  MXSER_BOARD_CP132_PCI },
 	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP114, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

--------------090908010301010804070007--

