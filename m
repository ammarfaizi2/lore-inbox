Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTI1NGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTI1NGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:06:45 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:27696 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262572AbTI1NGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:23 -0400
Date: Sun, 28 Sep 2003 14:55:36 +0200
Message-Id: <200309281255.h8SCtaka005630@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 326] Atari NCR5380 SCSI is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari NCR5380 SCSI is broken (needs old update_timeout() from scsi_obsolete)

--- linux-2.6.0-test6/drivers/scsi/Kconfig	Tue Sep  9 10:13:04 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/Kconfig	Thu Sep 18 05:14:16 2003
@@ -1648,7 +1648,7 @@
 
 config ATARI_SCSI
 	tristate "Atari native SCSI support"
-	depends on ATARI && SCSI
+	depends on ATARI && SCSI && BROKEN
 	---help---
 	  If you have an Atari with built-in NCR5380 SCSI controller (TT,
 	  Falcon, ...) say Y to get it supported. Of course also, if you have

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
