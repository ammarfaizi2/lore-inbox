Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUCJSOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbUCJSOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:14:41 -0500
Received: from witte.sonytel.be ([80.88.33.193]:18338 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262730AbUCJSLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:11:51 -0500
Date: Wed, 10 Mar 2004 19:11:44 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] CONFIG_NVRAM dependencies
Message-ID: <Pine.GSO.4.58.0403101909280.14075@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make CONFIG_NVRAM depend on the prerequisites that are explicitly checked for
in drivers/char/nvram.c, or on CONFIG_GENERIC_NVRAM (for PPC).

--- linux-2.6.4-rc3/drivers/char/Kconfig	2004-03-04 11:30:37.000000000 +0100
+++ linux-m68k-2.6.4-rc3/drivers/char/Kconfig	2004-03-04 18:04:57.000000000 +0100
@@ -740,6 +740,7 @@

 config NVRAM
 	tristate "/dev/nvram support"
+	depends on ATARI || X86 || X86_64 || ARM || GENERIC_NVRAM
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
