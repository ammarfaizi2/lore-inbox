Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272918AbTHKRVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272799AbTHKQtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:46 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:601 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272803AbTHKQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:30 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] LDM 64bit fixup
Message-Id: <E19mFqr-000688-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/partitions/ldm.h linux-2.5/fs/partitions/ldm.h
--- bk-linus/fs/partitions/ldm.h	2003-04-10 06:01:28.000000000 +0100
+++ linux-2.5/fs/partitions/ldm.h	2003-07-16 19:25:20.000000000 +0100
@@ -38,8 +38,8 @@ struct parsed_partitions;
 /* Magic numbers in CPU format. */
 #define MAGIC_VMDB	0x564D4442		/* VMDB */
 #define MAGIC_VBLK	0x56424C4B		/* VBLK */
-#define MAGIC_PRIVHEAD	0x5052495648454144	/* PRIVHEAD */
-#define MAGIC_TOCBLOCK	0x544F43424C4F434B	/* TOCBLOCK */
+#define MAGIC_PRIVHEAD	0x5052495648454144ULL	/* PRIVHEAD */
+#define MAGIC_TOCBLOCK	0x544F43424C4F434BULL	/* TOCBLOCK */
 
 /* The defined vblk types. */
 #define VBLK_VOL5		0x51		/* Volume,     version 5 */
