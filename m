Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSIIS2M>; Mon, 9 Sep 2002 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSIIS2M>; Mon, 9 Sep 2002 14:28:12 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:3456 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S318757AbSIIS2L>;
	Mon, 9 Sep 2002 14:28:11 -0400
Date: Mon, 9 Sep 2002 20:32:51 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.34: recalc_sigpending missing for modules
Message-ID: <20020909183251.GA2026@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  when recalc_sigpending was converted from inline to real function,
appropriate EXPORT_SYMBOL() was not created. Needed at least for ncpfs
and lockd.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/kernel/signal.c linux/kernel/signal.c
--- linux/kernel/signal.c	2002-09-09 18:01:49.000000000 +0000
+++ linux/kernel/signal.c	2002-09-09 18:25:09.000000000 +0000
@@ -1220,6 +1220,7 @@
 
 #endif
 
+EXPORT_SYMBOL(recalc_sigpending);
 EXPORT_SYMBOL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
 EXPORT_SYMBOL(force_sig);
