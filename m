Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVAEAIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVAEAIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVADVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:43:45 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:20726 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262291AbVADVk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:40:58 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214115.21749.90823.19119@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 4/7] ppc: remove cli()/sti() in arch/ppc/platforms/apus_setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:40:55 -0600
Date: Tue, 4 Jan 2005 15:40:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/platforms/apus_setup.c linux-2.6.10-mm1/arch/ppc/platforms/apus_setup.c
--- linux-2.6.10-mm1-original/arch/ppc/platforms/apus_setup.c	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/platforms/apus_setup.c	2005-01-03 19:29:40.720694742 -0500
@@ -480,7 +480,7 @@
 void
 apus_restart(char *cmd)
 {
-	cli();
+	local_irq_disable();
 
 	APUS_WRITE(APUS_REG_LOCK,
 		   REGLOCK_BLACKMAGICK1|REGLOCK_BLACKMAGICK2);
