Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbULYRdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbULYRdV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULYRdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:33:21 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:24448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261538AbULYRdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:33:18 -0500
Date: Sat, 25 Dec 2004 18:29:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: signal.c: convert assertion to BUG_ON()
Message-ID: <20041225172939.GA7495@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Convert assertion code to BUG_ON(). Please apply,
								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-cvs/kernel/signal.c	2004-11-19 12:21:32.000000000 +0100
+++ linux-cvs/kernel/signal.c	2004-12-10 22:35:59.000000000 +0100
@@ -1442,8 +1442,7 @@
 	unsigned long flags;
 	struct sighand_struct *psig;
 
-	if (sig == -1)
-		BUG();
+	BUG_ON(sig == -1);
 
  	/* do_notify_parent_cldstop should have been called instead.  */
  	BUG_ON(tsk->state & (TASK_STOPPED|TASK_TRACED));


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
