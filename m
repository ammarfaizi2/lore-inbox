Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSGYQF1>; Thu, 25 Jul 2002 12:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSGYQF0>; Thu, 25 Jul 2002 12:05:26 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:27630 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315265AbSGYQFZ>;
	Thu, 25 Jul 2002 12:05:25 -0400
Date: Thu, 25 Jul 2002 18:08:38 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207251608.SAA20142@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL][PATCH][2.5] drm/mga bitops -> long fix
Cc: trivial@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silence bitop on non-long argument warnings.

--- linux-2.5.28/drivers/char/drm/mga_drv.h.~1~	Wed Feb 20 03:11:05 2002
+++ linux-2.5.28/drivers/char/drm/mga_drv.h	Thu Jul 25 02:13:02 2002
@@ -38,7 +38,7 @@
 
 	u32 tail;
 	int space;
-	volatile int wrapped;
+	volatile long wrapped;
 
 	volatile u32 *status;
 
