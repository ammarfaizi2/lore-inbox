Return-Path: <linux-kernel-owner+w=401wt.eu-S932411AbWLaBGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWLaBGK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWLaBFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:05:53 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:45807 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932439AbWLaBFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:05:21 -0500
Message-id: <1548321969210043378@wsc.cz>
In-reply-to: <152402571305932932@wsc.cz>
Subject: [PATCH 7/8] Char: moxa, use PCI_DEVICE
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 02:05:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, use PCI_DEVICE

Use PCI_DEVICE macro in pci_device_id list.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 5b7f53b3500ebd3aa2cc25bb68fdcd88af3643c0
tree 8392124992e5eeb1eaad6f652468f1b1caa65dac
parent 9e4d8826dd1dbaa7bb9d520b02da25a5a5cefa13
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:56:01 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:56:01 +0059

 drivers/char/moxa.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 5c0c0e6..a0eb088 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -83,12 +83,12 @@ static char *moxa_brdname[] =
 
 #ifdef CONFIG_PCI
 static struct pci_device_id moxa_pcibrds[] = {
-	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C218, PCI_ANY_ID, PCI_ANY_ID, 
-	  0, 0, MOXA_BOARD_C218_PCI },
-	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C320, PCI_ANY_ID, PCI_ANY_ID, 
-	  0, 0, MOXA_BOARD_C320_PCI },
-	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP204J, PCI_ANY_ID, PCI_ANY_ID, 
-	  0, 0, MOXA_BOARD_CP204J },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C218),
+		.driver_data = MOXA_BOARD_C218_PCI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C320),
+		.driver_data = MOXA_BOARD_C320_PCI },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP204J),
+		.driver_data = MOXA_BOARD_CP204J },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, moxa_pcibrds);
