Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312268AbSCTXIb>; Wed, 20 Mar 2002 18:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312267AbSCTXIW>; Wed, 20 Mar 2002 18:08:22 -0500
Received: from 217-127-135-237.uc.nombres.ttd.es ([217.127.135.237]:35312 "EHLO
	pulp.ibd.es") by vger.kernel.org with ESMTP id <S312266AbSCTXIK>;
	Wed, 20 Mar 2002 18:08:10 -0500
Subject: [PATCH] Too much debug info from ide-tape
From: Alfredo =?ISO-8859-1?Q?Sanju=E1n?= <alfre@IBD.es>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 21 Mar 2002 00:06:35 +0100
Message-Id: <1016665600.1831.13.camel@den.ibd.es>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Marcelo.

	This little patch removes too much DEBUG info from
drivers/ide/ide-tape.c. This is for vanilla 2.4.18.

--alfredo

-------------------------------------------------------

diff -ur linux-2.4.18/drivers/ide/ide-tape.c linux-2.4.18new/drivers/ide/ide-tape.c
--- linux-2.4.18/drivers/ide/ide-tape.c	Fri Dec 21 18:41:54 2001
+++ linux-2.4.18new/drivers/ide/ide-tape.c	Wed Mar 20 23:48:11 2002
@@ -3096,10 +3096,10 @@
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_read_position_result_t *result;
 	
-//#if IDETAPE_DEBUG_LOG
-//	if (tape->debug_level >= 4)
+#if IDETAPE_DEBUG_LOG
+	if (tape->debug_level >= 4)
 		printk (KERN_INFO "ide-tape: Reached idetape_read_position_callback\n");
-//#endif /* IDETAPE_DEBUG_LOG */
+#endif /* IDETAPE_DEBUG_LOG */
 
 	if (!tape->pc->error) {
 		result = (idetape_read_position_result_t *) tape->pc->buffer;
@@ -3273,10 +3273,10 @@
 	idetape_pc_t pc;
 	int position;
 
-//#if IDETAPE_DEBUG_LOG
-//        if (tape->debug_level >= 4)
+#if IDETAPE_DEBUG_LOG
+        if (tape->debug_level >= 4)
 	printk (KERN_INFO "ide-tape: Reached idetape_read_position\n");
-//#endif /* IDETAPE_DEBUG_LOG */
+#endif /* IDETAPE_DEBUG_LOG */
 
 #ifdef NO_LONGER_REQUIRED
 	idetape_flush_tape_buffers(drive);

------------------------------------------------------------------------

