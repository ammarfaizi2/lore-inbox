Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVAEAIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVAEAIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVADVnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:43:25 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:7598 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262325AbVADVlR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:41:17 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214133.21749.77003.29062@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 6/7] ppc: remove cli()/sti() in arch/ppc/syslib/m8xx_setup.c
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:41:13 -0600
Date: Tue, 4 Jan 2005 15:41:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/syslib/m8xx_setup.c linux-2.6.10-mm1/arch/ppc/syslib/m8xx_setup.c
--- linux-2.6.10-mm1-original/arch/ppc/syslib/m8xx_setup.c	2004-12-24 16:34:32.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/syslib/m8xx_setup.c	2005-01-03 19:26:53.224307353 -0500
@@ -238,7 +238,7 @@
 {
 	__volatile__ unsigned char dummy;
 
-	cli();
+	local_irq_disable();
 	((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;
 
 	/* Clear the ME bit in MSR to cause checkstop on machine check
