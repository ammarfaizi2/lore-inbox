Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTJMIaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTJMIaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:30:13 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:40248 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261552AbTJMIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:30:05 -0400
Date: Mon, 13 Oct 2003 10:31:20 +0200
Message-Id: <200310130831.h9D8VKKg015688@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 338] Sun-3 compile fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3: Add missing include (needed because of __attribute_used__ in
<linux/init.h>)

--- linux-2.6.0-test7/arch/m68k/sun3/sbus.c	Thu Jan  2 12:53:58 2003
+++ linux-m68k-2.6.0-test7/arch/m68k/sun3/sbus.c	Sun Sep 28 12:09:58 2003
@@ -10,6 +10,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/compiler.h>
 #include <linux/init.h>
 
 int __init sbus_init(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
