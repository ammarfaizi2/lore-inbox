Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbSKQDWE>; Sat, 16 Nov 2002 22:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbSKQDWE>; Sat, 16 Nov 2002 22:22:04 -0500
Received: from [203.94.130.164] ([203.94.130.164]:43944 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S267452AbSKQDWE>;
	Sat, 16 Nov 2002 22:22:04 -0500
Date: Sun, 17 Nov 2002 13:07:22 +1100 (EST)
From: Brett <brett@bad-sports.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix pcmcia qlogicfas build in 2.5
Message-ID: <Pine.LNX.4.44.0211171305410.13918-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Alan's recent driver update of the qlogicfas scsi card broke the pcmcia 
version.  This patch fixes it.

thanks,

	/ Brett Pemberton

--- drivers/scsi/pcmcia/qlogic_stub.c.old	2002-11-17 14:02:54.000000000 +1100
+++ drivers/scsi/pcmcia/qlogic_stub.c	2002-11-17 14:02:44.000000000 +1100
@@ -50,7 +50,7 @@
 
 #include <../drivers/scsi/qlogicfas.h>
 
-#define qlogic_reset(h) qlogicfas_reset(h, 0)
+#define qlogic_reset(h) qlogicfas_bus_reset(h)
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>

