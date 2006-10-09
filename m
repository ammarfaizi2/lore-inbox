Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWJIH2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWJIH2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWJIH2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:28:07 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:20540 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932283AbWJIH2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:28:05 -0400
Date: Mon, 9 Oct 2006 09:26:38 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch] Disable DETECT_SOFTLOCKUP for s390.
Message-ID: <20061009072638.GA6936@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

We got several false bug reports because of enabled CONFIG_DETECT_SOFTLOCKUP.
Disable soft lockup detection on s390, since it doesn't work on a virtualized
architecture.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/lib/Kconfig.debug
===================================================================
--- linux-2.6.orig/lib/Kconfig.debug	2006-10-09 09:15:26.000000000 +0200
+++ linux-2.6/lib/Kconfig.debug	2006-10-09 09:25:17.000000000 +0200
@@ -71,7 +71,7 @@
 
 config DETECT_SOFTLOCKUP
 	bool "Detect Soft Lockups"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !S390
 	default y
 	help
 	  Say Y here to enable the kernel to detect "soft lockups",
