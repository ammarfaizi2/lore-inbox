Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWBUDsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWBUDsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbWBUDsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:14 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:10685 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161305AbWBUDsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:09 -0500
Message-Id: <20060221034750.186509000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:33 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>,
       Jeff Dike <jdike@karaya.com>
Subject: [-mm patch 5/8] um: fix undefined reference to hweight32
Content-Disposition: inline; filename=uml-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Build fix for user mode linux.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
Cc: Jeff Dike <jdike@karaya.com>

 arch/um/Kconfig.i386   |    5 +++++
 arch/um/Kconfig.x86_64 |    5 +++++
 2 files changed, 10 insertions(+)

Index: 2.6-mm/arch/um/Kconfig.i386
===================================================================
--- 2.6-mm.orig/arch/um/Kconfig.i386
+++ 2.6-mm/arch/um/Kconfig.i386
@@ -52,3 +52,8 @@ config ARCH_HAS_SC_SIGNALS
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default y
+
+config GENERIC_HWEIGHT
+	bool
+	default y
+
Index: 2.6-mm/arch/um/Kconfig.x86_64
===================================================================
--- 2.6-mm.orig/arch/um/Kconfig.x86_64
+++ 2.6-mm/arch/um/Kconfig.x86_64
@@ -46,3 +46,8 @@ config ARCH_REUSE_HOST_VSYSCALL_AREA
 config SMP_BROKEN
 	bool
 	default y
+
+config GENERIC_HWEIGHT
+	bool
+	default y
+

--
