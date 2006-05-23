Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWEWSyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWEWSyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWEWSyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:54:54 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:33720 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932259AbWEWSyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:54:52 -0400
Date: Tue, 23 May 2006 20:54:51 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: use proper defines for i8259A I/O
Message-ID: <20060523185451.GG10827@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

use proper defines instead of "dirty" code using open-coded values...

i386 run-tested on 2.6.17-rc4-mm3.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/i8259.c linux-2.6.17-rc4-mm3.my/arch/i386/kernel/i8259.c
--- linux-2.6.17-rc4-mm3.orig/arch/i386/kernel/i8259.c	2006-05-23 19:14:13.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/i386/kernel/i8259.c	2006-05-22 15:47:03.000000000 +0200
@@ -271,8 +271,8 @@
 	 * the kernel initialization code can get it
 	 * out of.
 	 */
-	outb(0xff, 0x21);	/* mask all of 8259A-1 */
-	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
 	return 0;
 }
 
