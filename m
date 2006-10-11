Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWJKMjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWJKMjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWJKMjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:39:36 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:46572 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751111AbWJKMjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:39:35 -0400
Subject: [PATCH 2/2] drivers/cdrom/sonycd535.c: Replacing yield() with a
	better alternative
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 18:12:57 +0530
Message-Id: <1160570577.19143.303.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/cdrom/sonycd535.c linux-2.6.19-rc1/drivers/cdrom/sonycd535.c
--- linux-2.6.19-rc1-orig/drivers/cdrom/sonycd535.c	2006-09-21 10:15:32.000000000 +0530
+++ linux-2.6.19-rc1/drivers/cdrom/sonycd535.c	2006-10-11 17:29:15.000000000 +0530
@@ -342,7 +342,7 @@ static inline void
 sony_sleep(void)
 {
 	if (sony535_irq_used <= 0) {	/* poll */
-		yield();
+		schedule_timeout_interruptible(1);
 	} else {	/* Interrupt driven */
 		DEFINE_WAIT(wait);
 		


