Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTI1N1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTI1NG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:06:59 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:59459 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262567AbTI1NGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:15 -0400
Date: Sun, 28 Sep 2003 14:55:28 +0200
Message-Id: <200309281255.h8SCtS0g005570@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 316] Amiga GVP-II SCSI is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga GVP-II SCSI is broken (needs SCSI device list updates and
gvp11_bus_reset())

--- linux-2.6.0-test6/drivers/scsi/Kconfig	Tue Sep  9 10:13:04 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/Kconfig	Thu Sep 18 05:14:16 2003
@@ -1562,7 +1562,7 @@
 
 config GVP11_SCSI
 	tristate "GVP Series II WD33C93A support"
-	depends on ZORRO && SCSI
+	depends on ZORRO && SCSI && BROKEN
 	---help---
 	  If you have a Great Valley Products Series II SCSI controller,
 	  answer Y. Also say Y if you have a later model of GVP SCSI

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
