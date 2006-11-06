Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753468AbWKFRJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbWKFRJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbWKFRJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:09:12 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:27553 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1753468AbWKFRJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:09:10 -0500
Message-Id: <20061106170220.580198000@mvista.com>
User-Agent: quilt/0.45-1
Date: Mon, 06 Nov 2006 09:02:20 -0800
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Cc: John Stultz <johnstul@us.ibm.com>
Subject: [PATCH] clocksource: add usage of CONFIG_SYSFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply adds some ifdefs to remove clocksoure sysfs code when CONFIG_SYSFS
isn't turn on.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>
Acked-by: John Stultz <johnstul@us.ibm.com>

---
 kernel/time/clocksource.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.18/kernel/time/clocksource.c
===================================================================
--- linux-2.6.18.orig/kernel/time/clocksource.c
+++ linux-2.6.18/kernel/time/clocksource.c
@@ -186,6 +186,7 @@ void clocksource_reselect(void)
 }
 EXPORT_SYMBOL(clocksource_reselect);
 
+#ifdef CONFIG_SYSFS
 /**
  * sysfs_show_current_clocksources - sysfs interface for current clocksource
  * @dev:	unused
@@ -307,6 +308,7 @@ static int __init init_clocksource_sysfs
 }
 
 device_initcall(init_clocksource_sysfs);
+#endif /* CONFIG_SYSFS */
 
 /**
  * boot_override_clocksource - boot clock override
--

