Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUDFLfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUDFLeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:34:36 -0400
Received: from witte.sonytel.be ([80.88.33.193]:26756 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263781AbUDFLcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:32:43 -0400
Date: Tue, 6 Apr 2004 13:32:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Ben Collins <bcollins@debian.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: [PATCH] ieee1394 missing include
Message-ID: <Pine.GSO.4.58.0404061331580.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in_interrupt() needs <linux/sched.h> on some platforms

--- linux-2.6.5/drivers/ieee1394/csr1212.h.orig	2004-02-29 09:31:37.000000000 +0100
+++ linux-2.6.5/drivers/ieee1394/csr1212.h	2004-02-29 12:37:11.000000000 +0100
@@ -37,6 +37,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>

 #define CSR1212_MALLOC(size)		kmalloc((size), in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
 #define CSR1212_FREE(ptr)		kfree(ptr)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
