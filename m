Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271157AbUJVBSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271157AbUJVBSB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271156AbUJVBPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:15:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:177 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271158AbUJVBGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:06:02 -0400
Subject: [PATCH] ppc64: Fix typo in zImage boot wrapper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098407111.6028.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 11:05:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in the zImage boot wrapper (incorrect printf).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Matthew Dharm <mdharm@momenco.com>

===== arch/ppc64/boot/main.c 1.9 vs edited =====
--- 1.9/arch/ppc64/boot/main.c	2004-09-20 18:17:40 -07:00
+++ edited/arch/ppc64/boot/main.c	2004-10-21 14:17:06 -07:00
@@ -166,7 +166,7 @@
 		gunzip((void *)vmlinux.addr, vmlinux.size,
 			(unsigned char *)vmlinuz.addr, &len);
 		printf("done 0x%lx bytes\n\r", len);
-		printf("0x%x bytes of heap consumed, max in use 0x%\n\r",
+		printf("0x%x bytes of heap consumed, max in use 0x%x\n\r",
 		       (unsigned)(avail_high - begin_avail), heap_max);
 	} else {
 		memmove((void *)vmlinux.addr,(void *)vmlinuz.addr,vmlinuz.size);


