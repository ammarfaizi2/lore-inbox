Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263244AbUKULur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUKULur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUKULqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:46:00 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:27480 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261954AbUKULoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:44:20 -0500
Date: Sun, 21 Nov 2004 12:38:33 +0100
Message-Id: <200411211138.iALBcXm9032355@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 530] M68k HP300 DIO bus: Fix typo in dio_resource_len()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP300 DIO bus: Fix typo in dio_resource_len()

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc2/include/linux/dio.h	2004-11-09 21:12:05.000000000 +0100
+++ linux-m68k-2.6.10-rc2/include/linux/dio.h	2004-11-21 10:52:25.000000000 +0100
@@ -254,7 +254,7 @@
 
 #define dio_resource_start(d) ((d)->resource.start)
 #define dio_resource_end(d)   ((d)->resource.end)
-#define dio_resource_len(d)   ((d)->resource.end-(z)->resource.start+1)
+#define dio_resource_len(d)   ((d)->resource.end-(d)->resource.start+1)
 #define dio_resource_flags(d) ((d)->resource.flags)
 
 #define dio_request_device(d, name) \

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
