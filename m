Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTIZMPB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTIZMN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:13:58 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:5675 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262069AbTIZMNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:13:46 -0400
Date: Fri, 26 Sep 2003 14:14:10 +0200
Message-Id: <200309261214.h8QCEA0d005024@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 119] Q40/Q60 frame buffer device
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

q40fb: Relax checking of parameters that are ignored anyway (from Richard
Zidlicky)

--- linux-2.4.23-pre5/drivers/video/q40fb.c	Fri Sep 13 10:16:48 2002
+++ linux-m68k-2.4.23-pre5/drivers/video/q40fb.c	Mon Sep  1 13:34:42 2003
@@ -148,6 +148,8 @@
 		return -EINVAL;
 	if(var->activate!=FB_ACTIVATE_NOW)
 		return -EINVAL;
+// ignore broken tools trying to set these values
+#if 0
 	if(var->pixclock!=0)
 		return -EINVAL;
 	if(var->left_margin!=0)
@@ -162,6 +164,7 @@
 		return -EINVAL;
 	if(var->vmode!=FB_VMODE_NONINTERLACED)
 		return -EINVAL;
+#endif
 
 	return 0;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
