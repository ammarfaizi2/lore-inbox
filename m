Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946115AbWJSPbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946115AbWJSPbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946117AbWJSPbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:31:47 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:2542 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1946115AbWJSPbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:31:46 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.19-rc2-mm1: make net2280 compile without CONFIG_USB_GADGET_DEBUG_FILES
Date: Thu, 19 Oct 2006 17:31:07 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191731.07406.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_USB_GADGET_DEBUG_FILES is disabled, net2280 #defines 
device_create_file(a,b) to do {} while (0).
Later on, it does result = device_create_file(.....)

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>

--- linux-2.6.18/drivers/usb/gadget/net2280.c.ark	2006-10-19 
16:38:59.000000000 +0200
+++ linux-2.6.18/drivers/usb/gadget/net2280.c	2006-10-19 17:18:36.000000000 
+0200
@@ -1774,7 +1774,7 @@
 
 #else
 
-#define device_create_file(a,b)	do {} while (0)
+#define device_create_file(a,b)	0
 #define device_remove_file	device_create_file
 
 #endif
