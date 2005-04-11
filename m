Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVDKWk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVDKWk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVDKWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:40:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9901 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261972AbVDKWkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:40:05 -0400
Date: Tue, 12 Apr 2005 00:39:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch, I hope you like it better this way :-)] fix few remaining u32 vs. pm_message_t problems in -mm3
Message-ID: <20050411223941.GA3439@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes remaining u32 vs. pm_message_t confusions in
-rc2-mm3. [There are usb changes, too; they went to Greg on his
request.]

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/drivers/macintosh/via-pmu.c	2005-04-11 22:53:30.000000000 +0200
+++ linux-mm/drivers/macintosh/via-pmu.c	2005-04-11 23:09:13.000000000 +0200
@@ -2371,7 +2371,7 @@
 	 * use this but still... This will take care of sysdev's as well, so
 	 * we exit from here with local irqs disabled and PIC off.
 	 */
-	ret = device_power_down(PM_SUSPEND_MEM);
+	ret = device_power_down(PMSG_SUSPEND);
 	if (ret) {
 		wakeup_decrementer();
 		local_irq_enable();

