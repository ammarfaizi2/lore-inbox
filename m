Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVAGOZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVAGOZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVAGOZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:25:33 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60156 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261420AbVAGOZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:25:05 -0500
Date: Fri, 7 Jan 2005 15:25:00 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200501071425.j07EP0s17995@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] remove NR_SUPER define
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last month I removed the "or too many mounted filesystems"
part from an error message in mount(8) - NR_SUPER has not
been used in a very long time.
Also NR_RESERVED_FILES is unused today.

Andries

diff -uprN -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2004-12-04 16:18:23.000000000 +0100
+++ b/include/linux/fs.h	2004-12-20 00:17:28.000000000 +0100
@@ -68,8 +68,6 @@ extern int dir_notify_enable;
 #endif
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
-#define NR_RESERVED_FILES 10 /* reserved for root */
-#define NR_SUPER 256
 
 #define MAY_EXEC 1
 #define MAY_WRITE 2
