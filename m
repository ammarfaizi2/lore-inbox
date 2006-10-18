Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422708AbWJRRTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWJRRTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWJRRTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:19:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12350 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422708AbWJRRTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:19:00 -0400
Date: Wed, 18 Oct 2006 13:18:59 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix PXA2xx UDC compilation error
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0610181315530.1971@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was apparently missed by the move to the generic IRQ code.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/drivers/usb/gadget/pxa2xx_udc.c b/drivers/usb/gadget/pxa2xx_udc.c
index f42c00e..671c24b 100644
--- a/drivers/usb/gadget/pxa2xx_udc.c
+++ b/drivers/usb/gadget/pxa2xx_udc.c
@@ -43,11 +43,11 @@ #include <linux/proc_fs.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/irq.h>
 
 #include <asm/byteorder.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/mach-types.h>
 #include <asm/unaligned.h>
