Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWETCxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWETCxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 22:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWETCxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 22:53:24 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:63389 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964831AbWETCxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 22:53:23 -0400
Date: Fri, 19 May 2006 19:53:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] i386 Don't conside oprofile EXPERIMENTAL anymore
Message-ID: <20060520025322.GD9486@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oprofile isn't new and a lot of developers use it.  Drop the
EXPERIMENTAL.


Signed-off-by: Chris Wedgwood <cw@f00f.org>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 5b1a7d4..2b8657d 100644
Index: linux-2.6/arch/i386/Kconfig
===================================================================
--- linux-2.6.orig/arch/i386/Kconfig	2006-05-19 19:35:35.586394755 -0700
+++ linux-2.6/arch/i386/Kconfig	2006-05-19 19:35:38.866552357 -0700
@@ -1053,7 +1053,6 @@
 source "fs/Kconfig"
 
 menu "Instrumentation Support"
-	depends on EXPERIMENTAL
 
 source "arch/i386/oprofile/Kconfig"
 
Index: linux-2.6/arch/i386/oprofile/Kconfig
===================================================================
--- linux-2.6.orig/arch/i386/oprofile/Kconfig	2006-05-19 19:35:32.644253387 -0700
+++ linux-2.6/arch/i386/oprofile/Kconfig	2006-05-19 19:35:38.866552357 -0700
@@ -1,12 +1,12 @@
 config PROFILING
-	bool "Profiling support (EXPERIMENTAL)"
+	bool "Profiling support"
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
 	  
 
 config OPROFILE
-	tristate "OProfile system profiling (EXPERIMENTAL)"
+	tristate "OProfile system profiling"
 	depends on PROFILING
 	help
 	  OProfile is a profiling system capable of profiling the
