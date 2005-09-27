Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVI0MFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVI0MFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVI0MFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:05:47 -0400
Received: from mail.renesas.com ([202.234.163.13]:63166 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S964910AbVI0MFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:05:46 -0400
Date: Tue, 27 Sep 2005 21:05:41 +0900 (JST)
Message-Id: <20050927.210541.846961981.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.14-rc2-mm1] m32r: buildfix of m32r_sio.c
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes build errors of -mm kernels, 2.6.14-rc1-mm1 or later.
Please apply.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/serial/m32r_sio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.14-rc2-mm1/drivers/serial/m32r_sio.c
===================================================================
--- linux-2.6.14-rc2-mm1.orig/drivers/serial/m32r_sio.c	2005-09-27 20:53:39.000000000 +0900
+++ linux-2.6.14-rc2-mm1/drivers/serial/m32r_sio.c	2005-09-27 20:53:46.000000000 +0900
@@ -386,7 +386,7 @@ static _INLINE_ void receive_chars(struc
 		if ((*status & up->port.ignore_status_mask) == 0)
 			tty_insert_flip_char(tty, ch, flag);
 
-		if (*status & UART_LSR_OE)
+		if (*status & UART_LSR_OE) {
 			/*
 			 * Overrun is special, since it's reported
 			 * immediately, and doesn't affect the current

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
