Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbTIFBul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTIFBsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:48:52 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:15376 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S263526AbTIFBsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:48:05 -0400
Subject: [PATCH] 2.6.0-test4 SEQ_START_TOKEN drivers/net (5/6)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1062812890.16851.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 18:48:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.6.0-test4/drivers/net/pppoe.c SEQ_START_TOKEN/drivers/net/pppoe.c
-- linux-2.6.0-test4/drivers/net/pppoe.c	2003-08-22 16:57:18.000000000 -0700
+++ SEQ_START_TOKEN/drivers/net/pppoe.c	2003-09-04 19:46:59.000000000 -0700
@@ -986,7 +986,7 @@
 	struct pppox_opt *po;
 	char *dev_name;
 
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Id       Address              Device\n");
 		goto out;
 	}
@@ -1025,7 +1025,7 @@
 	loff_t l = *pos;
 
 	read_lock_bh(&pppoe_hash_lock);
-	return l ? pppoe_get_idx(--l) : (void *)1;
+	return l ? pppoe_get_idx(--l) : SEQ_START_TOKEN;
 }
 
 static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1033,7 +1033,7 @@
 	struct pppox_opt *po;
 
 	++*pos;
-	if (v == (void *)1) {
+	if (v == SEQ_START_TOKEN) {
 		po = pppoe_get_idx(0);
 		goto out;
 	}


