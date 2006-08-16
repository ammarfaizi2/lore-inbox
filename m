Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWHPLLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWHPLLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 07:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHPLKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 07:10:44 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:40109 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751104AbWHPLKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 07:10:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Date: Wed, 16 Aug 2006 13:14:11 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl>
In-Reply-To: <200608161304.51758.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161314.11128.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
by people who know exactly what they are doing, from Kconfig.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/Kconfig |   18 ------------------
 1 files changed, 18 deletions(-)

Index: linux-2.6.18-rc4-mm1/kernel/power/Kconfig
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/Kconfig
+++ linux-2.6.18-rc4-mm1/kernel/power/Kconfig
@@ -47,24 +47,6 @@ config PM_DISABLE_CONSOLE_SUSPEND
 	suspend/resume routines, but may itself lead to problems, for example
 	if netconsole is used.
 
-config PM_TRACE
-	bool "Suspend/resume event tracing"
-	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
-	default n
-	---help---
-	This enables some cheesy code to save the last PM event point in the
-	RTC across reboots, so that you can debug a machine that just hangs
-	during suspend (or more commonly, during resume).
-
-	To use this debugging feature you should attempt to suspend the machine,
-	then reboot it, then run
-
-		dmesg -s 1000000 | grep 'hash matches'
-
-	CAUTION: this option will cause your machine's real-time clock to be
-	set to an invalid time after a resume.
-
-
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
 	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
