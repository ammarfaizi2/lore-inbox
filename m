Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUHQLMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUHQLMC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268181AbUHQLMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:12:02 -0400
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:2688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265264AbUHQLLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:11:42 -0400
Date: Tue, 17 Aug 2004 13:11:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: fix default and merge upstream?
Message-ID: <20040817111128.GA4164@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Perhaps now is the right time to merge -mm swsusp up to Linus? I'd
like new swsusp to default to powerdown mode (as it did before) before
it goes up (attached patch)... But if you want to test ACPI code paths
even in Linus tree, leave it out.

								Pavel

--- clean-mm/kernel/power/main.c	2004-08-17 12:21:44.000000000 +0200
+++ linux-mm/kernel/power/main.c	2004-08-17 12:22:47.000000000 +0200
@@ -33,8 +33,6 @@
 {
 	down(&pm_sem);
 	pm_ops = ops;
-	if (ops->pm_disk_mode && ops->pm_disk_mode < PM_DISK_MAX)
-		pm_disk_mode = ops->pm_disk_mode;
 	up(&pm_sem);
 }
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
