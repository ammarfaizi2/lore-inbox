Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSHKLFR>; Sun, 11 Aug 2002 07:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSHKLFR>; Sun, 11 Aug 2002 07:05:17 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:1000 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318283AbSHKLFR>;
	Sun, 11 Aug 2002 07:05:17 -0400
Date: Sun, 11 Aug 2002 13:09:03 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200208111109.NAA19086@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] fix drm/mga bitops on non-long operands bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drm update from cvs in 2.5.31 reintroduced the mga driver's
bitops on non-long operands bug. The patch below fixes it.

/Mikael

--- linux-2.5.31/drivers/char/drm/mga_drv.h.~1~	Sun Aug 11 11:29:30 2002
+++ linux-2.5.31/drivers/char/drm/mga_drv.h	Sun Aug 11 11:58:20 2002
@@ -38,7 +38,7 @@
 
 	u32 tail;
 	int space;
-	int wrapped;
+	unsigned long wrapped;
 
 	volatile u32 *status;
 
