Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUKRWpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUKRWpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbUKRWoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:44:01 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:37687 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S262904AbUKRUtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:49:40 -0500
Date: Thu, 18 Nov 2004 21:49:35 +0100
Message-Id: <200411182049.iAIKnZCc007073@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 525] Sun-3: Fix link error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3: Fix link error (we forgot to update vmlinux-sun3.lds during last update
of vmlinux-std.lds)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/kernel/vmlinux-sun3.lds	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/kernel/vmlinux-sun3.lds	2004-11-10 21:10:31.000000000 +0100
@@ -16,7 +16,7 @@ SECTIONS
 	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x4e75
+	} :text = 0x4e75
 	RODATA
 
   _etext = .;			/* End of text section */
@@ -28,7 +28,7 @@ SECTIONS
 	__start___ex_table = .;
 	*(__ex_table)
 	__stop___ex_table = .;
-	}
+	} :data
   /* End of data goes *here* so that freeing init code works properly. */
   _edata = .;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
