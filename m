Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbUJ0Mih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUJ0Mih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUJ0Mih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:38:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:16336 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262408AbUJ0Mid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:38:33 -0400
Date: Wed, 27 Oct 2004 14:38:32 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove double newline from sysrq action_msg
Message-ID: <20041027123832.GA19052@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__handle_sysrq already prints a newline, so the action_msg string doesnt
need yet another newline.


diff -purN linux-2.6.9/arch/i386/mach-voyager/voyager_basic.c linux-2.6.10-rc1-bk6/arch/i386/mach-voyager/voyager_basic.c
--- linux-2.6.9/arch/i386/mach-voyager/voyager_basic.c	2004-10-18 23:53:45.000000000 +0200
+++ linux-2.6.10-rc1-bk6/arch/i386/mach-voyager/voyager_basic.c	2004-10-27 14:32:53.196332547 +0200
@@ -53,7 +53,7 @@ voyager_dump(int dummy1, struct pt_regs 
 static struct sysrq_key_op sysrq_voyager_dump_op = {
 	.handler	= voyager_dump,
 	.help_msg	= "Voyager",
-	.action_msg	= "Dump Voyager Status\n",
+	.action_msg	= "Dump Voyager Status",
 };
 #endif
 
diff -purN linux-2.6.9/arch/ppc/xmon/start.c linux-2.6.10-rc1-bk6/arch/ppc/xmon/start.c
--- linux-2.6.9/arch/ppc/xmon/start.c	2004-10-27 14:27:41.138618227 +0200
+++ linux-2.6.10-rc1-bk6/arch/ppc/xmon/start.c	2004-10-27 14:32:40.212360526 +0200
@@ -102,7 +102,7 @@ static struct sysrq_key_op sysrq_xmon_op
 {
 	.handler =	sysrq_handle_xmon,
 	.help_msg =	"Xmon",
-	.action_msg =	"Entering xmon\n",
+	.action_msg =	"Entering xmon",
 };
 #endif
 
diff -purN linux-2.6.9/arch/ppc64/xmon/start.c linux-2.6.10-rc1-bk6/arch/ppc64/xmon/start.c
--- linux-2.6.9/arch/ppc64/xmon/start.c	2004-10-27 14:27:55.870582096 +0200
+++ linux-2.6.10-rc1-bk6/arch/ppc64/xmon/start.c	2004-10-27 14:32:57.627307280 +0200
@@ -35,7 +35,7 @@ static struct sysrq_key_op sysrq_xmon_op
 {
 	.handler =	sysrq_handle_xmon,
 	.help_msg =	"Xmon",
-	.action_msg =	"Entering xmon\n",
+	.action_msg =	"Entering xmon",
 };
 
 static int __init setup_xmon_sysrq(void)
diff -purN linux-2.6.9/kernel/power/poweroff.c linux-2.6.10-rc1-bk6/kernel/power/poweroff.c
--- linux-2.6.9/kernel/power/poweroff.c	2004-10-18 23:54:08.000000000 +0200
+++ linux-2.6.10-rc1-bk6/kernel/power/poweroff.c	2004-10-27 14:33:05.269313716 +0200
@@ -32,7 +32,7 @@ static void handle_poweroff(int key, str
 static struct sysrq_key_op	sysrq_poweroff_op = {
 	.handler        = handle_poweroff,
 	.help_msg       = "powerOff",
-	.action_msg     = "Power Off\n"
+	.action_msg     = "Power Off"
 };
 
 static int pm_sysrq_init(void)
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
