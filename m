Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVCCVuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVCCVuD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVCCVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:49:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7690 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262616AbVCCVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:48:29 -0500
Date: Thu, 3 Mar 2005 22:48:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/power/smp.c: make a variable static
Message-ID: <20050303214826.GP4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/power/smp.c.old	2005-03-03 17:00:30.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/power/smp.c	2005-03-03 17:00:38.000000000 +0100
@@ -42,7 +42,7 @@
 	__restore_processor_state(&ctxt);
 }
 
-cpumask_t oldmask;
+static cpumask_t oldmask;
 
 void disable_nonboot_cpus(void)
 {

