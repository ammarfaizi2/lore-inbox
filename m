Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVAIIx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVAIIx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 03:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVAIIx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 03:53:58 -0500
Received: from mx1.mail.ru ([194.67.23.121]:54342 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262072AbVAIIxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 03:53:53 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: [PATCH] eventpoll: s/0/NULL/ in pointer context
Date: Sun, 9 Jan 2005 11:27:45 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501091127.45957.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-2.6.10-bk11-warnings/fs/eventpoll.c
===================================================================
--- linux-2.6.10-bk11-warnings/fs/eventpoll.c	(revision 6)
+++ linux-2.6.10-bk11-warnings/fs/eventpoll.c	(revision 7)
@@ -806,7 +806,7 @@
 	 * write-holding "sem" we can be sure that no file cleanup code will hit
 	 * us during this operation. So we can avoid the lock on "ep->lock".
 	 */
-	while ((rbp = rb_first(&ep->rbr)) != 0) {
+	while ((rbp = rb_first(&ep->rbr)) != NULL) {
 		epi = rb_entry(rbp, struct epitem, rbn);
 		ep_remove(ep, epi);
 	}
