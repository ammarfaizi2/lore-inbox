Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVDLTCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVDLTCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVDLTBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:01:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:59849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262221AbVDLKcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:41 -0400
Message-Id: <200504121032.j3CAWW9l005621@shell0.pdx.osdl.net>
Subject: [patch 121/198] fix few remaining u32 vs. pm_message_t problems
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, pavel@suse.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

This fixes remaining u32 vs.  pm_message_t confusions in -rc2-mm3.  [There
are usb changes, too; they went to Greg on his request.]

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/macintosh/via-pmu.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/macintosh/via-pmu.c~fix-few-remaining-u32-vs-pm_message_t-problems drivers/macintosh/via-pmu.c
--- 25/drivers/macintosh/via-pmu.c~fix-few-remaining-u32-vs-pm_message_t-problems	2005-04-12 03:21:32.775154320 -0700
+++ 25-akpm/drivers/macintosh/via-pmu.c	2005-04-12 03:21:32.779153712 -0700
@@ -2371,7 +2371,7 @@ pmac_suspend_devices(void)
 	 * use this but still... This will take care of sysdev's as well, so
 	 * we exit from here with local irqs disabled and PIC off.
 	 */
-	ret = device_power_down(PM_SUSPEND_MEM);
+	ret = device_power_down(PMSG_SUSPEND);
 	if (ret) {
 		wakeup_decrementer();
 		local_irq_enable();
_
