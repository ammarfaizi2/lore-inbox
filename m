Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTFVXw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 19:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTFVXw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 19:52:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11981 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264218AbTFVXw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 19:52:57 -0400
Date: Mon, 23 Jun 2003 02:07:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Will Dyson <will_dyson@pobox.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] postfix a BeFS u64 constant with ULL
Message-ID: <20030623000700.GC3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfix a BeFS u64 constant with ULL.

Please apply
Adrian

--- linux-2.5.73-not-full/fs/befs/btree.c.old	2003-06-23 01:55:34.000000000 +0200
+++ linux-2.5.73-not-full/fs/befs/btree.c	2003-06-23 02:01:24.000000000 +0200
@@ -86,7 +86,7 @@
 } befs_btree_node;
 
 /* local constants */
-static const befs_off_t befs_bt_inval = 0xffffffffffffffff;
+static const befs_off_t befs_bt_inval = 0xffffffffffffffffULL;
 
 /* local functions */
 static int befs_btree_seekleaf(struct super_block *sb, befs_data_stream * ds,
