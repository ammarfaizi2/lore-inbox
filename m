Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUFBJPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUFBJPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 05:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUFBJPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 05:15:35 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:59542 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262356AbUFBJPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 05:15:30 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix dependeces for CONFIG_USB_STORAGE
Date: Wed, 2 Jun 2004 11:16:35 +0200
User-Agent: KMail/1.5.4
Cc: "Linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406021116.35529.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missed dependence for CONFIG_USB_STORAGE.

Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>

--- linux/drivers/usb/storage/Kconfig.orig	2004-06-02 10:55:18.000000000 +0200
+++ linux/drivers/usb/storage/Kconfig	2004-06-02 10:56:03.000000000 +0200
@@ -6,6 +6,7 @@
 	tristate "USB Mass Storage support"
 	depends on USB
 	select SCSI
+	select BLK_DEV_SD
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
 	  computer's USB port. This is the driver you need for USB floppy drives,


-- 
	Paolo Ornati
	Linux v2.6.6

