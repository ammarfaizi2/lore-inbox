Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVIGWXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVIGWXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVIGWXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:23:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50060 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750781AbVIGWXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:23:52 -0400
Date: Wed, 7 Sep 2005 23:23:50 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bogus #if (simserial)
Message-ID: <20050907222350.GE13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-xfs/arch/ia64/hp/sim/simserial.c RC13-git7-simserial/arch/ia64/hp/sim/simserial.c
--- RC13-git7-xfs/arch/ia64/hp/sim/simserial.c	2005-08-28 23:09:39.000000000 -0400
+++ RC13-git7-simserial/arch/ia64/hp/sim/simserial.c	2005-09-07 13:55:40.000000000 -0400
@@ -130,7 +130,7 @@
 
 static void rs_start(struct tty_struct *tty)
 {
-#if SIMSERIAL_DEBUG
+#ifdef SIMSERIAL_DEBUG
 	printk("rs_start: tty->stopped=%d tty->hw_stopped=%d tty->flow_stopped=%d\n",
 		tty->stopped, tty->hw_stopped, tty->flow_stopped);
 #endif
