Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVAQIOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVAQIOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVAQINs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:13:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24333 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261634AbVAQINi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:13:38 -0500
Date: Mon, 17 Jan 2005 09:13:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Marco van Wieringen <mvw@planets.elm.net>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/acct.c: make a function static
Message-ID: <20050117081334.GZ4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

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
 

