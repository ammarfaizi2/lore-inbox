Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030700AbWAKAHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030700AbWAKAHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030702AbWAKAHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:07:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21752 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S1030700AbWAKAHB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:07:01 -0500
Date: Tue, 10 Jan 2006 16:06:55 -0800
Message-Id: <200601110006.k0B06tDI018868@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Make CONFIG_BLOCKER X86 only 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	That's the only arch I know of that it compiles on.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.15/drivers/char/Kconfig
===================================================================
--- linux-2.6.15.orig/drivers/char/Kconfig
+++ linux-2.6.15/drivers/char/Kconfig
@@ -722,7 +722,7 @@ config RTC_HISTOGRAM
 
 config BLOCKER
 	tristate "Priority Inheritance Debugging (Blocker) Device Support"
-	default y
+	default y if X86 
 	---help---
 	  If you say Y here then a device will be created that the userspace
 	  pi_test suite uses to test and measure kernel locking primitives.
