Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVD3UkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVD3UkC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVD3UIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:08:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4623 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261391AbVD3UHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:07:48 -0400
Date: Sat, 30 Apr 2005 22:07:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cpufreq/cpufreq_ondemand.c: make cpufreq_gov_dbs static
Message-ID: <20050430200746.GL3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global and EXPORT_SYMBOL'ed struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2005

--- linux-2.6.12-rc2-mm3-full/drivers/cpufreq/cpufreq_ondemand.c.old	2005-04-17 18:32:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/cpufreq/cpufreq_ondemand.c	2005-04-17 18:32:19.000000000 +0200
@@ -459,12 +459,11 @@
 	return 0;
 }
 
-struct cpufreq_governor cpufreq_gov_dbs = {
+static struct cpufreq_governor cpufreq_gov_dbs = {
 	.name		= "ondemand",
 	.governor	= cpufreq_governor_dbs,
 	.owner		= THIS_MODULE,
 };
-EXPORT_SYMBOL(cpufreq_gov_dbs);
 
 static int __init cpufreq_gov_dbs_init(void)
 {


