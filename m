Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVCIBtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVCIBtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVCIBpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:45:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41741 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262299AbVCIBo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:44:27 -0500
Date: Wed, 9 Mar 2005 02:44:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/power/smp.c: make a variable static
Message-ID: <20050309014410.GG3146@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

This patch was already ACK'ed by Pavel Machek.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Mar 2005

--- linux-2.6.11-rc5-mm1-full/kernel/power/smp.c.old	2005-03-03 17:00:30.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/power/smp.c	2005-03-03 17:00:38.000000000 +0100
@@ -42,7 +42,7 @@
 	__restore_processor_state(&ctxt);
 }
 
-cpumask_t oldmask;
+static cpumask_t oldmask;
 
 void disable_nonboot_cpus(void)
 {

