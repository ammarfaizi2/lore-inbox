Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVDQUBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVDQUBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVDQUAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:00:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2579 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261462AbVDQT7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:59:46 -0400
Date: Sun, 17 Apr 2005 21:59:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cpufreq/cpufreq_ondemand.c: make cpufreq_gov_dbs static
Message-ID: <20050417195942.GF3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global and EXPORT_SYMBOL'ed struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

