Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbUBBQLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUBBQLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:11:44 -0500
Received: from witte.sonytel.be ([80.88.33.193]:11700 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265700AbUBBQKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:10:48 -0500
Date: Mon, 2 Feb 2004 17:10:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-dvb-maintainer@linuxtv.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] DVB compile fix
Message-ID: <Pine.GSO.4.58.0402021709560.19699@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Never include <asm/delay.h> directly

--- linux-2.6.2-rc3/drivers/media/dvb/frontends/dst.c	2004-01-06 15:29:13.000000000 +0100
+++ linux-m68k-2.6.2-rc3/drivers/media/dvb/frontends/dst.c	2004-01-10 17:10:35.000000000 +0100
@@ -28,8 +28,8 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/delay.h>
 #include <asm/div64.h>
-#include <asm/delay.h>

 #include "dvb_frontend.h"
 #include "dvb_functions.h"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
