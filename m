Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268669AbUILLiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268669AbUILLiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUILLfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:35:11 -0400
Received: from aun.it.uu.se ([130.238.12.36]:52477 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268708AbUILLcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:32:06 -0400
Date: Sun, 12 Sep 2004 13:31:55 +0200 (MEST)
Message-Id: <200409121131.i8CBVtNI015256@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bcollins@debian.org, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] IEEE1394 driver core gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's IEEE1394 driver core. The changes are all backports from
the 2.6 kernel.

/Mikael

--- linux-2.4.28-pre3/drivers/ieee1394/highlevel.c.~1~	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.28-pre3/drivers/ieee1394/highlevel.c	2004-09-12 01:56:20.000000000 +0200
@@ -500,7 +500,7 @@
                                 rcode = RCODE_TYPE_ERROR;
                         }
 
-			(u8 *)data += partlength;
+			data += partlength;
                         length -= partlength;
                         addr += partlength;
 
@@ -546,7 +546,7 @@
                                 rcode = RCODE_TYPE_ERROR;
                         }
 
-			(u8 *)data += partlength;
+			data += partlength;
                         length -= partlength;
                         addr += partlength;
 
