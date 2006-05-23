Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWEWSyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWEWSyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWEWSyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:54:18 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:28856 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932270AbWEWSyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:54:16 -0400
Date: Tue, 23 May 2006 20:54:15 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
Subject: [PATCH] -mm: constify parts of kernel/power/
Message-ID: <20060523185415.GE10827@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

patch run-tested on linux-2.6.17-rc4-mm3.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/kernel/power/disk.c linux-2.6.17-rc4-mm3.my/kernel/power/disk.c
--- linux-2.6.17-rc4-mm3.orig/kernel/power/disk.c	2006-05-23 19:14:17.000000000 +0200
+++ linux-2.6.17-rc4-mm3/kernel/power/disk.c	2006-05-23 16:53:04.000000000 +0200
@@ -214,7 +214,7 @@
 }
 
 
-static char * pm_disk_modes[] = {
+static const char * const pm_disk_modes[] = {
 	[PM_DISK_FIRMWARE]	= "firmware",
 	[PM_DISK_PLATFORM]	= "platform",
 	[PM_DISK_SHUTDOWN]	= "shutdown",
diff -urN linux-2.6.17-rc4-mm3.orig/kernel/power/main.c linux-2.6.17-rc4-mm3.my/kernel/power/main.c
--- linux-2.6.17-rc4-mm3.orig/kernel/power/main.c	2006-05-23 19:13:20.000000000 +0200
+++ linux-2.6.17-rc4-mm3/kernel/power/main.c	2006-05-23 16:42:42.000000000 +0200
@@ -143,7 +143,7 @@
 
 
 
-static char *pm_states[PM_SUSPEND_MAX] = {
+static const char * const pm_states[PM_SUSPEND_MAX] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
 #ifdef CONFIG_SOFTWARE_SUSPEND
@@ -260,7 +260,7 @@
 static ssize_t state_store(struct subsystem * subsys, const char * buf, size_t n)
 {
 	suspend_state_t state = PM_SUSPEND_STANDBY;
-	char ** s;
+	const char * const * s;
 	char *p;
 	int error;
 	int len;
