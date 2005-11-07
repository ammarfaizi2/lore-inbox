Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965354AbVKGUG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965354AbVKGUG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbVKGUED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:04:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30482 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964901AbVKGUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:03:56 -0500
Date: Mon, 7 Nov 2005 21:03:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/sysrq.c: make two functions static
Message-ID: <20051107200355.GM3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Nov 2005

--- linux-2.6.14-rc5-mm1-full/drivers/char/sysrq.c.old	2005-11-03 16:37:52.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/char/sysrq.c	2005-11-03 16:38:54.000000000 +0100
@@ -378,7 +378,7 @@
         return op_p;
 }
 
-void __sysrq_put_key_op (int key, struct sysrq_key_op *op_p) {
+static void __sysrq_put_key_op (int key, struct sysrq_key_op *op_p) {
         int i;
 
 	i = sysrq_key_table_key2index(key);
@@ -443,7 +443,7 @@
 	__handle_sysrq(key, pt_regs, tty, 1);
 }
 
-int __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
+static int __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
                                 struct sysrq_key_op *remove_op_p) {
 
 	int retval;

