Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUDMJMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 05:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUDMJMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 05:12:19 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:63876 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263389AbUDMJMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 05:12:09 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 1/3] USB speedtouch: turn on debugging if CONFIG_USB_DEBUG is set
Date: Tue, 13 Apr 2004 11:12:04 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404131112.04621.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, this causes the speedtouch driver to output non-verbose
debugging messages if the kernel was configured with CONFIG_USB_DEBUG.
The patch is against your 2.6 kernel tree.

 speedtch.c |    4 ++++
 1 files changed, 4 insertions(+)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Tue Apr 13 10:57:33 2004
+++ b/drivers/usb/misc/speedtch.c	Tue Apr 13 10:57:33 2004
@@ -84,6 +84,10 @@
 #define VERBOSE_DEBUG
 */
 
+#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
+#	define DEBUG
+#endif
+
 #include <linux/usb.h>
 
 #ifdef DEBUG
