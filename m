Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTJMWMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 18:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbTJMWMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 18:12:16 -0400
Received: from imladris.surriel.com ([66.92.77.98]:32720 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262001AbTJMWMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 18:12:15 -0400
Date: Mon, 13 Oct 2003 18:12:04 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: root@ftp.linux.org.uk, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] add dummy release_irqlock() for alpha
Message-ID: <Pine.LNX.4.55L.0310131810580.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a real one on the other branch of this #ifdef, but
the dummy one seems useful too.

diff -urNp linux-5110/include/asm-alpha/hardirq.h linux-10010/include/asm-alpha/hardirq.h
--- linux-5110/include/asm-alpha/hardirq.h	2001-07-09 23:47:39.000000000 +0200
+++ linux-10010/include/asm-alpha/hardirq.h
@@ -41,6 +41,7 @@ extern unsigned long __irq_attempt[];

 #define synchronize_irq()	barrier()

+#define release_irqlock(cpu) ((void) 0)
 #else

 #define irq_attempt(cpu, irq) (cpu_data[cpu].irq_attempt[irq])
