Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTDQFvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTDQFu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:50:57 -0400
Received: from granite.he.net ([216.218.226.66]:49680 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263073AbTDQFux convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595052196@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <1050559505786@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:05 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1064, 2003/04/14 10:28:01-07:00, arndt@lin02384n012.mc.schoenewald.de

[PATCH] USB: Patch against unusual_devs.h to enable Pontis SP600


diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	Wed Apr 16 10:48:42 2003
+++ b/drivers/usb/storage/unusual_devs.h	Wed Apr 16 10:48:42 2003
@@ -299,6 +299,15 @@
                 US_SC_8070, US_PR_CBI, NULL,
                 US_FL_FIX_INQUIRY ),
 
+/* Enable USB storage access to the MMC/SD and CompactFlash cards inside the
+ * Pontis SP600 MP3 player (entry found on http://www.pontis.de/).
+ */
+UNUSUAL_DEV(  0x09bc, 0x0003, 0x0000, 0x9999,
+		"PONTIS",
+		"SP600",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_START_STOP ),
+
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x05ab, 0x0031, 0x0100, 0x0110,
 		"In-System",

