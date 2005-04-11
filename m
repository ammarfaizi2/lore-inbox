Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVDKXBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVDKXBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVDKXAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:00:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33165 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261993AbVDKW7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:59:39 -0400
Subject: [PATCH 3/3] mm/Kconfig: give DISCONTIG more help text
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, zippel@linux-m68k.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 11 Apr 2005 15:59:36 -0700
Message-Id: <E1DL7sX-00037u-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This gives DISCONTIGMEM a bit more help text to explain
what it does, not just when to choose it.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff -puN mm/Kconfig~A2-mm-Kconfig-DISCONTIG-help-text mm/Kconfig
--- memhotplug/mm/Kconfig~A2-mm-Kconfig-DISCONTIG-help-text	2005-04-11 15:49:10.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-04-11 15:49:10.000000000 -0700
@@ -23,6 +23,16 @@ config DISCONTIGMEM_MANUAL
 	bool "Discontigious Memory"
 	depends on ARCH_DISCONTIGMEM_ENABLE
 	help
+	  This option provides enhanced support for discontiguous
+	  memory systems, over FLATMEM.  These systems have holes
+	  in their physical address spaces, and this option provides
+	  more efficient handling of these holes.  However, the vast
+	  majority of hardware has quite flat address spaces, and
+	  can have degraded performance from extra overhead that
+	  this option imposes.
+
+	  Many NUMA configurations will have this as the only option.
+
 	  If unsure, choose "Flat Memory" over this option.
 
 endchoice
_
