Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVCOAIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVCOAIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVCOAHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:07:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:56797 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbVCOAHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:07:15 -0500
Date: Mon, 14 Mar 2005 16:07:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: dwmw2@infradead.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: use unsigned 1-bit fields
Message-Id: <20050314160701.494a50d8.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)

Fix (22) bitfield/boolean sparse warnings:
include/linux/mtd/flashchip.h:65:23: warning: dubious one-bit signed bitfield
include/linux/mtd/flashchip.h:66:23: warning: dubious one-bit signed bitfield

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 include/linux/mtd/flashchip.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./include/linux/mtd/flashchip.h~mtd_flashchip_bool ./include/linux/mtd/flashchip.h
--- ./include/linux/mtd/flashchip.h~mtd_flashchip_bool	2005-02-15 13:48:46.633263712 -0800
+++ ./include/linux/mtd/flashchip.h	2005-02-15 20:25:20.924981544 -0800
@@ -62,8 +62,8 @@ struct flchip {
 	flstate_t state;
 	flstate_t oldstate;
 
-	int write_suspended:1;
-	int erase_suspended:1;
+	unsigned int write_suspended:1;
+	unsigned int erase_suspended:1;
 	unsigned long in_progress_block_addr;
 
 	spinlock_t *mutex;


---
