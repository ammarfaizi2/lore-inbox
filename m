Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUL3Brc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUL3Brc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUL3Brc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:47:32 -0500
Received: from gamma.sinetgy.com ([212.85.33.222]:29925 "EHLO
	mailer.barrapunto.com") by vger.kernel.org with ESMTP
	id S261498AbUL3Br2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:47:28 -0500
Subject: [PATCH] USB storage: Make Pentax *ist DS works
From: Miquel Vidal <miquel@barrapunto.com>
To: Phil Dibowitz <phil@ipom.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1104371242.4557.53.camel@kusanagi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Dec 2004 02:47:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The change below in unusual_devs entries is needed to get the new Pentax
SLR *ist DS camera working. 

BR.
miquel

--- linux-2.6.10/drivers/usb/storage/unusual_devs.h.orig       
2004-12-30 02:26:25.000000000 +0100
+++ linux-2.6.10/drivers/usb/storage/unusual_devs.h     2004-12-30
02:26:18.000000000 +0100
@@ -775,7 +775,16 @@ UNUSUAL_DEV( 0x0a17, 0x006, 0x0000, 0xff
                 "Optio S/S4",
                 US_SC_DEVICE, US_PR_DEVICE, NULL,
                 US_FL_FIX_INQUIRY ),
-
+
+
+/* Submitted by Miquel Vidal <miquel@barrapunto.com> */
+UNUSUAL_DEV( 0x0a17, 0x0021, 0x0100, 0x0200,
+                "Pentax",
+                "*ist DS",
+                US_SC_DEVICE, US_PR_DEVICE, NULL,
+                US_FL_FIX_INQUIRY ),
+
+
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x0bf6, 0xa001, 0x0100, 0x0110,
                "ATI",



