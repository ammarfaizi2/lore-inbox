Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272804AbTHKQwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272810AbTHKQuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:50:05 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:1113 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272804AbTHKQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:30 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] BEFS 64bit fixup
Message-Id: <E19mFqq-000682-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/befs/btree.c linux-2.5/fs/befs/btree.c
--- bk-linus/fs/befs/btree.c	2003-04-10 06:01:26.000000000 +0100
+++ linux-2.5/fs/befs/btree.c	2003-07-13 16:55:50.000000000 +0100
@@ -86,7 +86,7 @@ typedef struct {
 } befs_btree_node;
 
 /* local constants */
-static const befs_off_t befs_bt_inval = 0xffffffffffffffff;
+static const befs_off_t befs_bt_inval = 0xffffffffffffffffULL;
 
 /* local functions */
 static int befs_btree_seekleaf(struct super_block *sb, befs_data_stream * ds,
