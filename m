Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269671AbUJTIYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269671AbUJTIYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUJTIXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:23:08 -0400
Received: from ozlabs.org ([203.10.76.45]:14771 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270208AbUJTIBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:01:04 -0400
Subject: [PATCH] Remove MODULE_PARM from arch/i386
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098259264.10571.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 18:01:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Remove MODULE_PARM from i386 arch
Status: Compiled on 2.6-bk
Depends: Module/MODULE_PARM-defconfig.patch.gz
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

This patch removes MODULE_PARM for everything under arch/i386.
Currently only APM.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3678-linux-2.6-bk/arch/i386/kernel/apm.c .3678-linux-2.6-bk.updated/arch/i386/kernel/apm.c
--- .3678-linux-2.6-bk/arch/i386/kernel/apm.c	2004-10-19 14:33:50.000000000 +1000
+++ .3678-linux-2.6-bk.updated/arch/i386/kernel/apm.c	2004-10-20 17:56:12.000000000 +1000
@@ -2393,27 +2393,27 @@ module_exit(apm_exit);
 MODULE_AUTHOR("Stephen Rothwell");
 MODULE_DESCRIPTION("Advanced Power Management");
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
+module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Enable debug mode");
-MODULE_PARM(power_off, "i");
+module_param(power_off, bool, 0444);
 MODULE_PARM_DESC(power_off, "Enable power off");
-MODULE_PARM(bounce_interval, "i");
+module_param(bounce_interval, int, 0444);
 MODULE_PARM_DESC(bounce_interval,
 		"Set the number of ticks to ignore suspend bounces");
-MODULE_PARM(allow_ints, "i");
+module_param(allow_ints, bool, 0444);
 MODULE_PARM_DESC(allow_ints, "Allow interrupts during BIOS calls");
-MODULE_PARM(broken_psr, "i");
+module_param(broken_psr, bool, 0444);
 MODULE_PARM_DESC(broken_psr, "BIOS has a broken GetPowerStatus call");
-MODULE_PARM(realmode_power_off, "i");
+module_param(realmode_power_off, bool, 0444);
 MODULE_PARM_DESC(realmode_power_off,
 		"Switch to real mode before powering off");
-MODULE_PARM(idle_threshold, "i");
+module_param(idle_threshold, int, 0444);
 MODULE_PARM_DESC(idle_threshold,
 	"System idle percentage above which to make APM BIOS idle calls");
-MODULE_PARM(idle_period, "i");
+module_param(idle_period, int, 0444);
 MODULE_PARM_DESC(idle_period,
 	"Period (in sec/100) over which to caculate the idle percentage");
-MODULE_PARM(smp, "i");
+module_param(smp, bool, 0444);
 MODULE_PARM_DESC(smp,
 	"Set this to enable APM use on an SMP platform. Use with caution on older systems");
 MODULE_ALIAS_MISCDEV(APM_MINOR_DEV);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

