Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVAaH23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVAaH23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVAaH0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:26:14 -0500
Received: from waste.org ([216.27.176.166]:9708 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261938AbVAaHZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:55 -0500
Date: Mon, 31 Jan 2005 01:25:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1.687457650@selenic.com>
Message-Id: <2.687457650@selenic.com>
Subject: [PATCH 1/8] base-small: introduce the CONFIG_BASE_SMALL flag
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_BASE_SMALL for miscellaneous core size that don't warrant
their own options. Example users to follow.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/init/Kconfig
===================================================================
--- mm2.orig/init/Kconfig	2005-01-30 21:26:29.000000000 -0800
+++ mm2/init/Kconfig	2005-01-30 21:51:08.000000000 -0800
@@ -286,6 +286,18 @@
 	   reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
 	   you wait for kallsyms to be fixed.
 
+config BASE_FULL
+	default y
+	bool "Enable full-sized data structures for core" if EMBEDDED
+	help
+	  Disabling this option reduces the size of miscellaneous core
+	  kernel data structures.
+
+config BASE_SMALL
+	int
+	default 0 if BASE_FULL
+	default 1 if !BASE_FULL
+
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
