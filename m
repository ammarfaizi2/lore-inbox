Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVCGTYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVCGTYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCGTLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:11:25 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:6406 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261240AbVCGTHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:07:45 -0500
Message-Id: <200503072038.j27Kcfbc003993@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 11/16] UML - add a comment explaining pread availability
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:38:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prompted by Dave Mielke: This adds a comment explaining why we do not
define _XOPEN_SOURCE, even though the pread man page says you should.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/cow_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/cow_user.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/cow_user.c	2005-03-05 12:19:11.000000000 -0500
@@ -1,6 +1,9 @@
 #include <stddef.h>
 #include <string.h>
 #include <errno.h>
+/* _XOPEN_SOURCE is needed for pread, but we define _GNU_SOURCE, which defines
+ * that.
+ */
 #include <unistd.h>
 #include <byteswap.h>
 #include <sys/time.h>

