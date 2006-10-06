Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWJFSF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWJFSF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWJFSF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:05:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422793AbWJFSF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:05:57 -0400
Date: Fri, 6 Oct 2006 11:05:49 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add Kconfig dependency !VT for VIOCONS
Message-ID: <20061006180549.GB3684@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Judith Lebzelter <judith@osdl.org>

Add Kconfig dependency !VT for VIOCONS

I would like to avoid this compile error in 'allmodconfig':
drivers/char/viocons.c:52:2: error: #error You must turn off CONFIG_VT to use CONFIG_VIOCONS

Signed-off-by: Judith Lebzelter <judith@osdl.org>
---

Index: linux/arch/powerpc/platforms/iseries/Kconfig
===================================================================
--- linux.orig/arch/powerpc/platforms/iseries/Kconfig	2006-10-05 09:35:09.000000000 -0700
+++ linux/arch/powerpc/platforms/iseries/Kconfig	2006-10-06 10:30:19.333425703 -0700
@@ -4,6 +4,7 @@
 
 config VIOCONS
 	tristate "iSeries Virtual Console Support (Obsolete)"
+	depends on !VT
 	help
 	  This is the old virtual console driver for legacy iSeries.
 	  You should use the iSeries Hypervisor Virtual Console
