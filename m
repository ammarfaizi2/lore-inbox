Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVGFCWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVGFCWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVGFCUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:20:54 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:56728 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262047AbVGFCTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:16 -0400
Subject: [PATCH] [1/48] Suspend2 2.1.9.8 for 2.6.12: submit_intro
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:39 +1000
Message-Id: <11206164393057@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 300-reboot-handler-hook.patch-old/kernel/sys.c 300-reboot-handler-hook.patch-new/kernel/sys.c
--- 300-reboot-handler-hook.patch-old/kernel/sys.c	2005-06-20 11:47:32.000000000 +1000
+++ 300-reboot-handler-hook.patch-new/kernel/sys.c	2005-07-04 23:14:18.000000000 +1000
@@ -436,12 +436,12 @@ asmlinkage long sys_reboot(int magic1, i
 		machine_restart(buffer);
 		break;
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#ifdef CONFIG_SUSPEND2
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
-			int ret = software_suspend();
+			suspend2_try_suspend();
 			unlock_kernel();
-			return ret;
+			return 0;
 		}
 #endif
 

