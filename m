Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUH3UCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUH3UCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUH3TxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:53:25 -0400
Received: from ppp-62-11-78-150.dialup.tiscali.it ([62.11.78.150]:7810 "EHLO
	zion.localdomain") by vger.kernel.org with ESMTP id S268925AbUH3Twm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:52:42 -0400
Subject: [patch 2/3] kbuild - remove old LDFLAGS_BLOB from Makefiles - docco update
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 30 Aug 2004 21:44:32 +0200
Message-Id: <20040830194432.85FC1529B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The LDFLAGS_BLOB var (which used to be defined in arch Makefiles) is now unused,
as specified inside usr/initramfs_data.S. So this patch updates the docs to mark
it as unused. You may prefer to drop the entire section about it, however I
wanted to make clear that this is a change from previous doc versions.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.8.1-paolo/Documentation/kbuild/makefiles.txt |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN Documentation/kbuild/makefiles.txt~doc-kbuild-LDFLAGS_BLOB-unused Documentation/kbuild/makefiles.txt
--- vanilla-linux-2.6.8.1/Documentation/kbuild/makefiles.txt~doc-kbuild-LDFLAGS_BLOB-unused	2004-08-30 16:02:33.080247296 +0200
+++ vanilla-linux-2.6.8.1-paolo/Documentation/kbuild/makefiles.txt	2004-08-30 16:02:33.082246992 +0200
@@ -647,6 +647,10 @@ When kbuild executes the following steps
 		#arch/i386/Makefile
 		LDFLAGS_BLOB := --format binary --oformat elf32-i386
 
+	Note that this flag has now (at least since 2.6.4) been REMOVED, since
+	a different mechanism is used (see comments at the beginning of
+	usr/initramfs_data.S).
+
     OBJCOPYFLAGS	objcopy flags
 
 	When $(call if_changed,objcopy) is used to translate a .o file,
_
