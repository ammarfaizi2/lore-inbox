Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVC0Og2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVC0Og2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVC0OgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:36:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13325 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261741AbVC0OfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:35:03 -0500
Date: Sun, 27 Mar 2005 16:35:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport idle_cpu
Message-ID: <20050327143502.GL4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2005

--- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old	2005-03-04 01:06:21.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/sched.c	2005-03-04 01:06:36.000000000 +0100
@@ -3387,8 +3387,6 @@
 	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
 }
 
-EXPORT_SYMBOL_GPL(idle_cpu);
-
 /**
  * idle_task - return the idle task for a given cpu.
  * @cpu: the processor in question.
