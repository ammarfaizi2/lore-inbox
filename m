Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWATJBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWATJBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWATJBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:01:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:20887 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750748AbWATJBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:01:41 -0500
Date: Fri, 20 Jan 2006 10:01:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: [patch] CONFIG_DOUBLEFAULT Kconfig fix
Message-ID: <20060120090159.GA9800@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

move CONFIG_DOUBLEFAULT from the main Kconfig menu (!) into its proper
place: the "Processor Type and features" submenu.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 arch/i386/Kconfig |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -55,15 +55,6 @@ config DMI
 
 source "init/Kconfig"
 
-config DOUBLEFAULT
-	default y
-	bool "Enable doublefault exception handler" if EMBEDDED
-	help
-          This option allows trapping of rare doublefault exceptions that
-          would otherwise cause a system to silently reboot. Disabling this
-          option saves about 4k and might cause you much additional grey
-          hair.
-
 menu "Processor type and features"
 
 choice
@@ -761,6 +752,15 @@ config HOTPLUG_CPU
 
 	  Say N.
 
+config DOUBLEFAULT
+	default y
+	bool "Enable doublefault exception handler" if EMBEDDED
+	help
+          This option allows trapping of rare doublefault exceptions that
+          would otherwise cause a system to silently reboot. Disabling this
+          option saves about 4k and might cause you much additional grey
+          hair.
+
 endmenu
 
 
