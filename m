Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUDBMQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUDBMQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:16:58 -0500
Received: from smtp2.a1.net ([194.48.125.37]:40668 "EHLO smtp.a1.net")
	by vger.kernel.org with ESMTP id S263027AbUDBMQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:16:57 -0500
Date: Sun, 04 Apr 2004 05:36:25 +0200
From: Brandstetter Thomas <linuxkernel@a1.net>
Subject: [PATCH] genesys usb 1.0 driver support
To: linux-kernel@vger.kernel.org
Message-id: <1081049785.5146.9.camel@localhost>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made this Patch to support the Genesys usb 1.0 driver. Without this
patch, i cannot get my external harddisk to work. 

I've tested it on a gentoo-dev-source 2.6.4-r1 kernel. It's stable and
working ;-)

greetings Thomas

email: linuxkernel@a1.net


--- unusual_devs.h_old  2004-03-27 17:54:56.016086192 +0000
+++ unusual_devs.h      2004-03-27 17:57:51.389425392 +0000
@@ -409,6 +409,14 @@
                US_SC_DEVICE, US_PR_DEVICE, NULL,
                US_FL_FIX_INQUIRY ),
  
+/* Submitted by Thomas Brandstetter <linuxkernel@a1.net>
+ * Fix for USB 1.0 Devices based on the Genesys Logic Chip */
+UNUSUAL_DEV( 0x05e3, 0x0702, 0x0113, 0x0113,
+               "GENESYS Logic",
+               "USB Storage Device",
+               US_SC_SCSI, US_PR_BULK, NULL,
+               US_FL_FIX_INQUIRY ),
+
 /* Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel */
 UNUSUAL_DEV(  0x0636, 0x0003, 0x0000, 0x9999,

