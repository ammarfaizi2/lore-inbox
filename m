Return-Path: <linux-kernel-owner+w=401wt.eu-S932513AbWLaBFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWLaBFO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWLaBFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:05:14 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:45804 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932513AbWLaBFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:05:11 -0500
Message-id: <3065114974316429934@wsc.cz>
In-reply-to: <152402571305932932@wsc.cz>
Subject: [PATCH 6/8] Char: moxa, devids cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 02:05:11 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, devids cleanup

Move them to pci_ids.h

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 9e4d8826dd1dbaa7bb9d520b02da25a5a5cefa13
tree 09ff5e387adce87a70c388e83af678fd5552062b
parent c2eee5df210da17dfdea909b89f5db31b577f92a
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:54:13 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:54:13 +0059

 drivers/char/moxa.c     |   19 +++----------------
 include/linux/pci_ids.h |    3 +++
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 3c8858c..5c0c0e6 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -64,19 +64,6 @@
 #define MOXA_BUS_TYPE_ISA		0
 #define MOXA_BUS_TYPE_PCI		1
 
-#ifndef	PCI_VENDOR_ID_MOXA
-#define	PCI_VENDOR_ID_MOXA	0x1393
-#endif
-#ifndef PCI_DEVICE_ID_CP204J
-#define PCI_DEVICE_ID_CP204J	0x2040
-#endif
-#ifndef PCI_DEVICE_ID_C218
-#define PCI_DEVICE_ID_C218	0x2180
-#endif
-#ifndef PCI_DEVICE_ID_C320
-#define PCI_DEVICE_ID_C320	0x3200
-#endif
-
 enum {
 	MOXA_BOARD_C218_PCI = 1,
 	MOXA_BOARD_C218_ISA,
@@ -96,11 +83,11 @@ static char *moxa_brdname[] =
 
 #ifdef CONFIG_PCI
 static struct pci_device_id moxa_pcibrds[] = {
-	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C218, PCI_ANY_ID, PCI_ANY_ID, 
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C218, PCI_ANY_ID, PCI_ANY_ID, 
 	  0, 0, MOXA_BOARD_C218_PCI },
-	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C320, PCI_ANY_ID, PCI_ANY_ID, 
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C320, PCI_ANY_ID, PCI_ANY_ID, 
 	  0, 0, MOXA_BOARD_C320_PCI },
-	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP204J, PCI_ANY_ID, PCI_ANY_ID, 
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP204J, PCI_ANY_ID, PCI_ANY_ID, 
 	  0, 0, MOXA_BOARD_CP204J },
 	{ 0 }
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 52d1e41..b9bf441 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1809,6 +1809,9 @@
 #define PCI_DEVICE_ID_MOXA_C168		0x1680
 #define PCI_DEVICE_ID_MOXA_CP168U	0x1681
 #define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
+#define PCI_DEVICE_ID_MOXA_CP204J	0x2040
+#define PCI_DEVICE_ID_MOXA_C218		0x2180
+#define PCI_DEVICE_ID_MOXA_C320		0x3200
 
 #define PCI_VENDOR_ID_CCD		0x1397
 #define PCI_DEVICE_ID_CCD_2BD0		0x2bd0
