Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288662AbSADPHJ>; Fri, 4 Jan 2002 10:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288668AbSADPG7>; Fri, 4 Jan 2002 10:06:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:7848 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288662AbSADPGq>;
	Fri, 4 Jan 2002 10:06:46 -0500
Message-Id: <200201041504.g04F4oc108294@westrelay03.boulder.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Paul Larson <plars@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] fix compile error in serial.c
Date: Fri, 4 Jan 2002 09:04:13 -0600
X-Mailer: KMail [version 1.3.1]
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I havn't seen a patch for this yet, so here it is.  Sorry for the duplicate 
if someone's already done it and I just didn't see it yet.

Thanks,
Paul Larson

--- linux-2.5.2-pre7/drivers/char/serial.c	Fri Jan  4 09:13:22 2002
+++ linux-new/drivers/char/serial.c	Fri Jan  4 10:01:03 2002
@@ -5827,7 +5827,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 /*
