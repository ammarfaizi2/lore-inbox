Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSGYQG2>; Thu, 25 Jul 2002 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSGYQG1>; Thu, 25 Jul 2002 12:06:27 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:37616 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315370AbSGYQG1>;
	Thu, 25 Jul 2002 12:06:27 -0400
Date: Thu, 25 Jul 2002 18:09:40 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207251609.SAA20425@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL][PATCH][2.5] ftape bitops -> long fix
Cc: trivial@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silence bitop on non-long argument warnings.

--- linux-2.5.28/drivers/char/ftape/zftape/zftape-init.c.~1~	Wed Feb 20 03:11:00 2002
+++ linux-2.5.28/drivers/char/ftape/zftape/zftape-init.c	Thu Jul 25 02:13:02 2002
@@ -67,7 +67,7 @@
 
 /*      Local vars.
  */
-static int busy_flag;
+static unsigned long busy_flag;
 
 static sigset_t orig_sigmask;
 
