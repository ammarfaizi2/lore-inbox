Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVGKAJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVGKAJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVGJTfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:35:14 -0400
Received: from mx1.suse.de ([195.135.220.2]:53394 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261184AbVGJTfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:10 -0400
Date: Sun, 10 Jul 2005 19:35:09 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: spyro@f2s.com, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 1/82] remove linux/version.h include from arch/arm*
Message-ID: <20050710193509.1.AyeCaI2278.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
remove one LINUX_VERSION_CODE check

Signed-off-by: Olaf Hering <olh@suse.de>

arch/arm/mach-omap/leds-h2p2-debug.c |    1 -
arch/arm/mach-omap/ocpi.c            |    1 -
arch/arm/nwfpe/fpmodule.c            |    1 -
arch/arm26/nwfpe/fpmodule.c          |    3 ---
4 files changed, 6 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/arm26/nwfpe/fpmodule.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/arm26/nwfpe/fpmodule.c
+++ linux-2.6.13-rc2-mm1/arch/arm26/nwfpe/fpmodule.c
@@ -24,7 +24,6 @@
#include "fpa11.h"

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/config.h>

/* XXX */
@@ -46,10 +45,8 @@ typedef struct task_struct*	PTASK;

#ifdef MODULE
void fp_send_sig(unsigned long sig, PTASK p, int priv);
-#if LINUX_VERSION_CODE > 0x20115
MODULE_AUTHOR("Scott Bambrough <scottb@rebel.com>");
MODULE_DESCRIPTION("NWFPE floating point emulator");
-#endif

#else
#define fp_send_sig	send_sig
Index: linux-2.6.13-rc2-mm1/arch/arm/mach-omap/leds-h2p2-debug.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/arm/mach-omap/leds-h2p2-debug.c
+++ linux-2.6.13-rc2-mm1/arch/arm/mach-omap/leds-h2p2-debug.c
@@ -13,7 +13,6 @@
#include <linux/init.h>
#include <linux/kernel_stat.h>
#include <linux/sched.h>
-#include <linux/version.h>

#include <asm/io.h>
#include <asm/hardware.h>
Index: linux-2.6.13-rc2-mm1/arch/arm/mach-omap/ocpi.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/arm/mach-omap/ocpi.c
+++ linux-2.6.13-rc2-mm1/arch/arm/mach-omap/ocpi.c
@@ -25,7 +25,6 @@

#include <linux/config.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/kernel.h>
Index: linux-2.6.13-rc2-mm1/arch/arm/nwfpe/fpmodule.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/arm/nwfpe/fpmodule.c
+++ linux-2.6.13-rc2-mm1/arch/arm/nwfpe/fpmodule.c
@@ -24,7 +24,6 @@
#include "fpa11.h"

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/config.h>

/* XXX */
