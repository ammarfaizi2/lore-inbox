Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWHNRwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWHNRwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWHNRwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:52:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:18359 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932569AbWHNRwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:52:03 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:50:49 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 6/8] ieee1394: sbp2: select SCSI in Kconfig
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.ae8a1f471d1f82f6@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konfiguration menu item of sbp2:  Replace 'depends on SCSI' by 'select
SCSI'.  Extend help text.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/Kconfig
===================================================================
--- linux.orig/drivers/ieee1394/Kconfig	2006-08-13 23:11:34.000000000 +0200
+++ linux/drivers/ieee1394/Kconfig	2006-08-14 00:28:03.000000000 +0200
@@ -122,10 +122,16 @@ config IEEE1394_VIDEO1394
 
 config IEEE1394_SBP2
 	tristate "SBP-2 support (Harddisks etc.)"
-	depends on IEEE1394 && SCSI && (PCI || BROKEN)
+	depends on IEEE1394 && (PCI || BROKEN)
+	select SCSI
 	help
-	  This option enables you to use SBP-2 devices connected to your IEEE
-	  1394 bus.  SBP-2 devices include harddrives and DVD devices.
+	  This option enables you to use SBP-2 devices connected to an IEEE
+	  1394 bus.  SBP-2 devices include storage devices like harddisks and
+	  DVD drives, also some other FireWire devices like scanners.
+
+	  This option depends on and will select basic SCSI support.  You
+	  should also enable support for disks, CD-ROMs, etc. in the SCSI
+	  configuration section.
 
 config IEEE1394_SBP2_PHYS_DMA
 	bool "Enable replacement for physical DMA in SBP2"


