Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWJIUWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWJIUWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWJIUWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:22:44 -0400
Received: from asia.telenet-ops.be ([195.130.137.74]:36583 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP id S964817AbWJIUWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:22:43 -0400
Date: Mon, 9 Oct 2006 22:22:37 +0200
Message-Id: <200610092022.k99KMbtC031450@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux/PA-RISC <parisc-linux@parisc-linux.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 562] m68k/HP300: Enable HIL configuration options
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HIL configuration options on HP300

Signed-Off-By: Kars de Jong <jongk@linux-m68k.org>
Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

---
 keyboard/Kconfig |    4 ++--
 misc/Kconfig     |    2 +-
 mouse/Kconfig    |    2 +-
 serio/Kconfig    |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

--- linux/drivers/input/keyboard/Kconfig	2005/06/18 16:15:57	1.1.1.12
+++ linux/drivers/input/keyboard/Kconfig	2005/08/29 19:17:44	1.2
@@ -154,7 +154,7 @@ config KEYBOARD_AMIGA
 
 config KEYBOARD_HIL_OLD
 	tristate "HP HIL keyboard support (simple driver)"
-	depends on GSC
+	depends on GSC || HP300
 	default y
 	help
 	  The "Human Interface Loop" is a older, 8-channel USB-like
@@ -171,7 +171,7 @@ config KEYBOARD_HIL_OLD
 
 config KEYBOARD_HIL
 	tristate "HP HIL keyboard support"
-	depends on GSC
+	depends on GSC || HP300
 	default y
 	select HP_SDC
 	select HIL_MLC
--- linux/drivers/input/misc/Kconfig	2005/06/18 16:15:58	1.1.1.12
+++ linux/drivers/input/misc/Kconfig	2005/08/29 19:17:44	1.2
@@ -51,7 +51,7 @@ config INPUT_UINPUT
 
 config HP_SDC_RTC
 	tristate "HP SDC Real Time Clock"       
-	depends on GSC
+	depends on GSC || HP300
 	select HP_SDC
 	help
 	  Say Y here if you want to support the built-in real time clock
--- linux/drivers/input/mouse/Kconfig	2005/06/18 16:15:58	1.1.1.18
+++ linux/drivers/input/mouse/Kconfig	2005/08/29 19:17:44	1.2
@@ -129,7 +129,7 @@ config MOUSE_VSXXXAA
 
 config MOUSE_HIL
 	tristate "HIL pointers (mice etc)."     
-	depends on GSC
+	depends on GSC || HP300
 	select HP_SDC
 	select HIL_MLC
 	help
--- linux/drivers/input/serio/Kconfig	2005/08/29 14:19:56	1.1.1.17
+++ linux/drivers/input/serio/Kconfig	2005/08/29 19:17:45	1.5
@@ -112,7 +112,7 @@ config SERIO_GSCPS2
 
 config HP_SDC
 	tristate "HP System Device Controller i8042 Support"
-	depends on GSC && SERIO
+	depends on (GSC || HP300) && SERIO
 	default y
 	---help---
 	  This option enables supports for the the "System Device

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
