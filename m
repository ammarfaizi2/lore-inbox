Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272568AbTG1AmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272567AbTG1AEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:10 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272723AbTG0W6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:17 -0400
Date: Sun, 27 Jul 2003 21:14:08 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272014.h6RKE8YH029704@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: phonedev has an owner so this is ok too I think
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/telephony/phonedev.c linux-2.6.0-test2-ac1/drivers/telephony/phonedev.c
--- linux-2.6.0-test2/drivers/telephony/phonedev.c	2003-07-10 21:11:35.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/telephony/phonedev.c	2003-07-14 17:05:52.000000000 +0100
@@ -106,7 +106,6 @@
 		if (phone_device[i] == NULL) {
 			phone_device[i] = p;
 			p->minor = i;
-			MOD_INC_USE_COUNT;
 			up(&phone_lock);
 			return 0;
 		}
@@ -126,7 +125,6 @@
 		panic("phone: bad unregister");
 	phone_device[pfd->minor] = NULL;
 	up(&phone_lock);
-	MOD_DEC_USE_COUNT;
 }
 
 
