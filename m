Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVA3A24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVA3A24 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 19:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVA3A24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 19:28:56 -0500
Received: from waste.org ([216.27.176.166]:3811 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261616AbVA3A2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 19:28:54 -0500
Date: Sat, 29 Jan 2005 16:28:48 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       karim@opersys.com
Subject: [PATCH] LTT config bits break config tree
Message-ID: <20050130002848.GD2891@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The LTT option got dropped in the middle of the CONFIG_EMBEDDED menu
without a dependency on EMBEDDED. Selecting EMBEDDED in menuconfig now
causes a bunch of random embedded options to appear on the general
options menu.

Not really sure if this belongs here or in the debugging menus.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/init/Kconfig
===================================================================
--- tq.orig/init/Kconfig	2005-01-29 16:17:03.000000000 -0800
+++ tq/init/Kconfig	2005-01-29 16:23:34.000000000 -0800
@@ -324,7 +324,7 @@
 config LTT
 	bool "Linux Trace Toolkit support"
 	select RELAYFS_FS
-	depends on !X86_64
+	depends on !X86_64 && EMBEDDED
 	default n
 	---help---
 	  It is possible for the kernel to log important events to a trace


-- 
Mathematics is the supreme nostalgia of our time.
