Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266518AbUAWGiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUAWGhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:37:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20946 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266518AbUAWGgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:43 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: Remove unused CONFIG symbol.
Message-Id: <E1Ajuub-0000x8-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grep of the tree only turned up these two uses.

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/defconfig linux-2.5/arch/i386/defconfig
--- bk-linus/arch/i386/defconfig	2003-09-29 19:45:30.000000000 +0100
+++ linux-2.5/arch/i386/defconfig	2003-12-11 06:01:18.000000000 +0000
@@ -1101,7 +1101,6 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_FRAME_POINTER=y
-CONFIG_X86_EXTRA_IRQS=y
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
 
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/Kconfig linux-2.5/arch/i386/Kconfig
--- bk-linus/arch/i386/Kconfig	2004-01-23 05:23:44.000000000 +0000
+++ linux-2.5/arch/i386/Kconfig	2004-01-23 05:43:37.000000000 +0000
@@ -1261,11 +1261,6 @@ config FRAME_POINTER
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
-config X86_EXTRA_IRQS
-	bool
-	depends on X86_LOCAL_APIC || X86_VOYAGER
-	default y
-
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
