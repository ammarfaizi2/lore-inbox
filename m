Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbUJZDji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUJZDji (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbUJZDja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:39:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:15832 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262140AbUJZDgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:36:43 -0400
Subject: [PATCH] ppc64: don't include <stddef.h>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 13:33:37 +1000
Message-Id: <1098761617.5154.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a couple of places where the ppc64 iSeries code would
#include <stddef.h>. The only "system" include I consider acceptable is
<stdarg.h> provided by gcc.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/pacaData.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pacaData.c	2004-10-17 12:07:06.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pacaData.c	2004-10-26 08:43:35.091369968 +1000
@@ -7,13 +7,12 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <asm/types.h>
-#include <asm/page.h>
-#include <stddef.h>
 #include <linux/config.h>
+#include <linux/types.h>
 #include <linux/threads.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
+#include <asm/page.h>
 
 #include <asm/iSeries/ItLpPaca.h>
 #include <asm/iSeries/ItLpQueue.h>
Index: linux-work/arch/ppc64/kernel/LparData.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/LparData.c	2004-10-21 11:47:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/LparData.c	2004-10-26 08:44:56.238033800 +1000
@@ -6,9 +6,8 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-#include <asm/types.h>
-#include <asm/page.h>
-#include <stddef.h>
+#include <linux/config.h>
+#include <linux/types.h>
 #include <linux/threads.h>
 #include <linux/module.h>
 #include <linux/bitops.h>


