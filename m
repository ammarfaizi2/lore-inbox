Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbULKPqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbULKPqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbULKPqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:46:42 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:899 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261951AbULKPqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:46:35 -0500
Date: Sat, 11 Dec 2004 16:46:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp fixes: fix confusing printk
Message-ID: <20041211154623.GA1888@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes confusing printk, please apply,
								Pavel

--- clean/kernel/power/swsusp.c	28 Oct 2004 15:21:34 -0000	1.29
+++ linux/kernel/power/swsusp.c	10 Dec 2004 21:35:59 -0000
@@ -1128,7 +1108,7 @@
 		 */
 		error = bio_write_page(0, &swsusp_header);
 	} else { 
-		pr_debug(KERN_ERR "swsusp: Invalid partition type.\n");
+		pr_debug(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
 	}
 	if (!error)

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
