Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSKROHv>; Mon, 18 Nov 2002 09:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSKROHu>; Mon, 18 Nov 2002 09:07:50 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:6272 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262662AbSKROHr>;
	Mon, 18 Nov 2002 09:07:47 -0500
Date: Mon, 18 Nov 2002 15:14:37 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] llc & 2.5.48
Message-ID: <20021118141437.GB10815@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   patch below fixes couple of compilation warnings in llc.
Please apply.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/net/llc/llc_main.c linux/net/llc/llc_main.c
--- linux/net/llc/llc_main.c	2002-11-18 13:50:40.000000000 +0000
+++ linux/net/llc/llc_main.c	2002-11-18 13:55:51.000000000 +0000
@@ -181,22 +181,22 @@
 	llc->inc_cntr = llc->dec_cntr = 2;
 	llc->dec_step = llc->connect_step = 1;
 
-	init_timer(&llc->ack_timer);
+	init_timer(&llc->ack_timer.timer);
 	llc->ack_timer.expire	      = LLC_ACK_TIME;
 	llc->ack_timer.timer.data     = (unsigned long)sk;
 	llc->ack_timer.timer.function = llc_conn_ack_tmr_cb;
 
-	init_timer(&llc->pf_cycle_timer);
+	init_timer(&llc->pf_cycle_timer.timer);
 	llc->pf_cycle_timer.expire	   = LLC_P_TIME;
 	llc->pf_cycle_timer.timer.data     = (unsigned long)sk;
 	llc->pf_cycle_timer.timer.function = llc_conn_pf_cycle_tmr_cb;
 
-	init_timer(&llc->rej_sent_timer);
+	init_timer(&llc->rej_sent_timer.timer);
 	llc->rej_sent_timer.expire	   = LLC_REJ_TIME;
 	llc->rej_sent_timer.timer.data     = (unsigned long)sk;
 	llc->rej_sent_timer.timer.function = llc_conn_rej_tmr_cb;
 
-	init_timer(&llc->busy_state_timer);
+	init_timer(&llc->busy_state_timer.timer);
 	llc->busy_state_timer.expire	     = LLC_BUSY_TIME;
 	llc->busy_state_timer.timer.data     = (unsigned long)sk;
 	llc->busy_state_timer.timer.function = llc_conn_busy_tmr_cb;
