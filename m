Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTJAQDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTJAQDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:03:08 -0400
Received: from [61.95.227.64] ([61.95.227.64]:9118 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S262111AbTJAQDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:03:07 -0400
Subject: [PATCH 2.6] comx-hw-munich.c: trivial warning fix
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1065024212.7194.340.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 01 Oct 2003 21:33:32 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a pointer cast warning on 64 bit platforms

--- linux-2.6.0-test6/drivers/net/wan/comx-hw-munich.c	2003-10-01 14:03:16.000000000 +0530
+++ linux-2.6.0-test6-nvk/drivers/net/wan/comx-hw-munich.c	2003-10-01 21:29:47.000000000 +0530
@@ -1849,7 +1849,7 @@
     if (board->isx21)
     {
 	init_timer(&board->modemline_timer);
-	board->modemline_timer.data = (unsigned int)board;
+	board->modemline_timer.data = (unsigned long)board;
 	board->modemline_timer.function = pcicom_modemline;
 	board->modemline_timer.expires = jiffies + HZ;
 	add_timer((struct timer_list *)&board->modemline_timer);


