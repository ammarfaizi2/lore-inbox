Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbULLTN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbULLTN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbULLTN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:13:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1808 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261878AbULLTN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:13:56 -0500
Date: Sun, 12 Dec 2004 20:13:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marco van Wieringen <mvw@planets.elm.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/acct.c: make a function static
Message-ID: <20041212191343.GT22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/kernel/acct.c.old	2004-12-12 02:39:22.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/acct.c	2004-12-12 02:39:30.000000000 +0100
@@ -170,7 +170,7 @@
  *
  * NOTE: acct_globals.lock MUST be held on entry and exit.
  */
-void acct_file_reopen(struct file *file)
+static void acct_file_reopen(struct file *file)
 {
 	struct file *old_acct = NULL;
 

