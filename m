Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVADABY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVADABY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVACX53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:57:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26374 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262002AbVACXxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:53:41 -0500
Date: Tue, 4 Jan 2005 00:53:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] cachefs: possible cleanups
Message-ID: <20050103235340.GS2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- journal.c: make cachefs_ondisc_ujnl_marks static
- misc.c: #if 0 the unused global function __cachefs_page_get_private


diffstat output:
 fs/cachefs/journal.c |    2 +-
 fs/cachefs/misc.c    |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm1-full/fs/cachefs/journal.c.old	2005-01-03 23:53:49.000000000 +0100
+++ linux-2.6.10-mm1-full/fs/cachefs/journal.c	2005-01-03 23:54:09.000000000 +0100
@@ -19,7 +19,7 @@
 
 #define UJNL_WRAP(X) ((X) & (CACHEFS_ONDISC_UJNL_NUMENTS - 1))
 
-const char *cachefs_ondisc_ujnl_marks[] = {
+static const char *cachefs_ondisc_ujnl_marks[] = {
 	"Null     ",
 	"Batch    ",
 	"Ack      ",
--- linux-2.6.10-mm1-full/fs/cachefs/misc.c.old	2005-01-03 23:54:20.000000000 +0100
+++ linux-2.6.10-mm1-full/fs/cachefs/misc.c	2005-01-03 23:54:37.000000000 +0100
@@ -30,6 +30,7 @@
  * get a page caching token from for a page, allocating it and attaching it to
  * the page's private pointer if it doesn't exist
  */
+#if 0
 struct fscache_page * __cachefs_page_get_private(struct page *page,
 						 unsigned gfp_flags)
 {
@@ -51,6 +52,7 @@
 } /* end __cachefs_page_get_private() */
 
 EXPORT_SYMBOL(__cachefs_page_get_private);
+#endif  /*  0  */
 
 /*****************************************************************************/
 /*

