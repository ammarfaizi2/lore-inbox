Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264341AbTCXRE2>; Mon, 24 Mar 2003 12:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264334AbTCXQt6>; Mon, 24 Mar 2003 11:49:58 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:39402 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264282AbTCXQa4>; Mon, 24 Mar 2003 11:30:56 -0500
Message-Id: <200303241642.h2OGg335008247@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:50 +0000
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: tulip irq patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another bit thats been in my tree for so long, I've
forgotten where it came from. ISTR it had something
to do with a quad port card.

Does this make any sense at all?

		Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/tulip/tulip_core.c linux-2.5/drivers/net/tulip/tulip_core.c
--- bk-linus/drivers/net/tulip/tulip_core.c	2003-03-08 09:57:19.000000000 +0000
+++ linux-2.5/drivers/net/tulip/tulip_core.c	2003-02-26 10:52:03.000000000 +0000
@@ -1547,7 +1549,7 @@ static int __devinit tulip_init_one (str
 #endif
 #if defined(__i386__)		/* Patch up x86 BIOS bug. */
 		if (last_irq)
-			irq = last_irq;
+			dev->irq = last_irq;
 #endif
 	}
 
