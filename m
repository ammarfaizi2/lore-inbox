Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWFZF3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWFZF3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWFZF3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:29:50 -0400
Received: from xenotime.net ([66.160.160.81]:17118 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964773AbWFZF3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:29:48 -0400
Date: Sun, 25 Jun 2006 22:31:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH} kernel/acct: fix function definition
Message-Id: <20060625223134.349e7ed8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

kernel/acct.c:579:19: warning: non-ANSI function declaration of function 'acct_process'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 kernel/acct.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g9.orig/kernel/acct.c
+++ linux-2617-g9/kernel/acct.c
@@ -576,7 +576,7 @@ void acct_collect(long exitcode, int gro
  *
  * handles process accounting for an exiting task
  */
-void acct_process()
+void acct_process(void)
 {
 	struct file *file = NULL;
 


---
