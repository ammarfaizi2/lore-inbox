Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbTEMA0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTEMA0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:26:07 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:31473 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263020AbTEMA0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:26:05 -0400
Date: Mon, 12 May 2003 17:38:01 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix net/rxrpc/proc.c
Message-ID: <20030512173801.A20068@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change in 2.5.69-bk from Yoshfuji broke compilation of rxrpc
code.  It erroneously adds an owner field to the rxrpc_proc_peers_ops
seq_operations.  Fix below.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== net/rxrpc/proc.c 1.3 vs edited =====
--- 1.3/net/rxrpc/proc.c	Sat May 10 11:46:35 2003
+++ edited/net/rxrpc/proc.c	Mon May 12 17:25:12 2003
@@ -52,7 +52,6 @@
 static int rxrpc_proc_peers_show(struct seq_file *m, void *v);
 
 static struct seq_operations rxrpc_proc_peers_ops = {
-	.owner	= THIS_MODULE,
 	.start	= rxrpc_proc_peers_start,
 	.next	= rxrpc_proc_peers_next,
 	.stop	= rxrpc_proc_peers_stop,
