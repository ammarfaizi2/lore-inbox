Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVHWVo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVHWVo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVHWVo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:44:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13238 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932440AbVHWVoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:24 -0400
To: torvalds@osdl.org
Subject: [PATCH] (32/43) m32r_sio gcc4 fixes
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gcB-0007Du-7B@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

extern declaration followed by static in drivers/serial/m32r_sio.c

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-icu_data/drivers/serial/m32r_sio.c RC13-rc6-git13-m32r-sio/drivers/serial/m32r_sio.c
--- RC13-rc6-git13-m32r-icu_data/drivers/serial/m32r_sio.c	2005-08-10 10:37:51.000000000 -0400
+++ RC13-rc6-git13-m32r-sio/drivers/serial/m32r_sio.c	2005-08-21 13:17:14.000000000 -0400
@@ -1123,7 +1123,7 @@
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-extern struct uart_driver m32r_sio_reg;
+static struct uart_driver m32r_sio_reg;
 static struct console m32r_sio_console = {
 	.name		= "ttyS",
 	.write		= m32r_sio_console_write,
