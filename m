Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSLUERj>; Fri, 20 Dec 2002 23:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSLUERj>; Fri, 20 Dec 2002 23:17:39 -0500
Received: from stone.protocoloweb.com.br ([200.226.139.11]:12305 "EHLO
	smtp.ieg.com.br") by vger.kernel.org with ESMTP id <S261963AbSLUERj>;
	Fri, 20 Dec 2002 23:17:39 -0500
Subject: USB/Storage - transport.c - Olympus D150Zoom
From: Scorpion <scorpionlab@ieg.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 21 Dec 2002 01:31:23 -0200
Message-Id: <1040441486.3708.25.camel@beyond>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
I was trying to put my digital camera Olympus Brio Zoom D-150Zoom
to work on my RedHat 7.3 (2.4.18-3, redhat) when found this web page:
http://www.gingerbear.org/~esm/olympus/

Clicking on transport.c.diff link and taking a look into
/usr/src/linux-2.4.18-3/drivers/usb/storage/transport.c file
I started to ask my self what is doing the
if (bcs.Signature != cpu_to_le32(US_BULK_CS_SIGN) ||
statement there? Please if anyone could, answer me...
The patch applied to "support" this camera just remove this comparison,
so what it does?

Best regards,
Scorpion.
---------------transport.c.diff----------------
--- drivers/usb/storage/transport.c	2002/08/07 13:14:59	1.1
+++ drivers/usb/storage/transport.c	2002/08/07 13:15:08
@@ -1197,8 +1197,7 @@
 	US_DEBUGP("Bulk status Sig 0x%x T 0x%x R %d Stat 0x%x\n",
 		  le32_to_cpu(bcs.Signature), bcs.Tag, 
 		  bcs.Residue, bcs.Status);
-	if (bcs.Signature != cpu_to_le32(US_BULK_CS_SIGN) || 
-	    bcs.Tag != bcb.Tag || 
+	if (bcs.Tag != bcb.Tag || 
 	    bcs.Status > US_BULK_STAT_PHASE || partial != 13) {
 		US_DEBUGP("Bulk logical error\n");
 		return USB_STOR_TRANSPORT_ERROR;
---------------transport.c.diff----------------


