Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVAaNFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVAaNFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVAaNDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:03:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:14302 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261186AbVAaNDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:03:17 -0500
Date: Mon, 31 Jan 2005 14:03:12 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, developers@melware.de
Subject: [PATCH 2/3] 2.6 ISDN Eicon driver: vfree()
Message-ID: <41FE2C90.mailD941K10WQ@phoenix.one.melware.de>
User-Agent: nail 11.4 8/29/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: armin@melware.de (Armin Schindler)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed check for NULL pointer before doing vfree(), it's done in
vfree().

Signed-off-by: Armin Schindler <armin@melware.de>


diff -Nur linux.orig/drivers/isdn/hardware/eicon/platform.h linux/drivers/isdn/hardware/eicon/platform.h
--- linux.orig/drivers/isdn/hardware/eicon/platform.h	2005-01-31 12:35:17.644106966 +0100
+++ linux/drivers/isdn/hardware/eicon/platform.h	2005-01-31 13:26:14.640422282 +0100
@@ -1,4 +1,4 @@
-/* $Id: platform.h,v 1.37.4.2 2004/08/28 20:03:53 armin Exp $
+/* $Id: platform.h,v 1.37.4.6 2005/01/31 12:22:20 armin Exp $
  *
  * platform.h
  * 
@@ -195,9 +195,7 @@
 }
 static __inline__ void  diva_os_free   (unsigned long flags, void* ptr)
 {
-	if (ptr) {
-		vfree(ptr);
-	}
+	vfree(ptr);
 }
 
 /*
