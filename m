Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbUKRWpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbUKRWpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUKRWoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:44:08 -0500
Received: from amsfep20-int.chello.nl ([213.46.243.18]:27456 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S262923AbUKRUtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:49:39 -0500
Date: Thu, 18 Nov 2004 21:49:35 +0100
Message-Id: <200411182049.iAIKnZJ6007068@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 524] 68851 MMU: Fix harmless typo in the MMU configuration code.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

68851 MMU: Fix harmless (CPU_68020 == MMU_68851 anyway) typo in the MMU
configuration code.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/include/asm-m68k/setup.h	15 Aug 2004 14:19:18 -0000	1.1.1.3
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/setup.h	7 Nov 2004 19:06:23 -0000
@@ -264,7 +264,7 @@ extern int m68k_is040or060;
 #  define MMU_IS_SUN3 (0)
 #elif defined(CONFIG_M68030) || defined(CONFIG_M68040) || defined(CONFIG_M68060)
 #  define CPU_IS_020 (m68k_cputype & CPU_68020)
-#  define MMU_IS_851 (m68k_cputype & MMU_68851)
+#  define MMU_IS_851 (m68k_mmutype & MMU_68851)
 #  define MMU_IS_SUN3 (0)	/* Sun3 not supported with other CPU enabled */
 #else
 #  define CPU_M68020_ONLY

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
