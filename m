Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVKKUnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVKKUnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVKKUnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:43:13 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62885 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751183AbVKKUnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:43:13 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051111204312.11609.23222.sendpatchset@localhost.localdomain>
Subject: [PATCH 2.6.14-rt11 1/3] Fix LPPTEST Kconfig dependancies
Date: Fri, 11 Nov 2005 15:42:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the LPPTEST driver depends on an x86-PC, make the Kconfig choice
do so as well.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

 drivers/char/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.14/drivers/char/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/char/Kconfig
+++ linux-2.6.14/drivers/char/Kconfig
@@ -729,7 +729,7 @@ config BLOCKER
 
 config LPPTEST
 	tristate "Parallel Port Based Latency Measurement Device"
-	depends on !PARPORT
+	depends on !PARPORT && X86
 	default y
 	---help---
 	  If you say Y here then a device will be created that the userspace

-- 
Tom
