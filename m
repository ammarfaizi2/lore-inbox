Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVAVAS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVAVAS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVAVARb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:17:31 -0500
Received: from waste.org ([216.27.176.166]:36743 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262632AbVAVAKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:10:03 -0500
Date: Fri, 21 Jan 2005 18:09:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1.464233479@selenic.com>
Message-Id: <2.464233479@selenic.com>
Subject: [PATCH 1/8] core-small: Add option to embedded menu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_CORE_SMALL for miscellaneous core size that don't warrant
their own options. Example users to follow.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/init/Kconfig
===================================================================
--- tiny.orig/init/Kconfig	2004-12-04 15:42:40.394703286 -0800
+++ tiny/init/Kconfig	2004-12-04 19:24:36.404346070 -0800
@@ -287,6 +287,12 @@
 	   reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
 	   you wait for kallsyms to be fixed.
 
+config CORE_SMALL
+	default n
+	bool "Enable various size reductions for core" if EMBEDDED
+	help
+	  This reduces the size of miscellaneous core kernel data structures.
+
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
