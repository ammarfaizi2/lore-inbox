Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUBBQKM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbUBBQKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:10:12 -0500
Received: from witte.sonytel.be ([80.88.33.193]:19379 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265695AbUBBQKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:10:03 -0500
Date: Mon, 2 Feb 2004 17:09:50 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: kai.germaschewski@gmx.de, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
cc: sdn4linux@listserv.isdn4linux.de,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Hisax compile fix
Message-ID: <Pine.GSO.4.58.0402021708530.19699@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Never include <asm/delay.h> directly

--- linux-2.6.2-rc3/drivers/isdn/hisax/hisax_hfcpci.c	2003-08-09 21:42:55.000000000 +0200
+++ linux-m68k-2.6.2-rc3/drivers/isdn/hisax/hisax_hfcpci.c	2004-01-10 05:09:24.000000000 +0100
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include "hisax_hfcpci.h"

 // debugging cruft

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
