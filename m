Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVBAQKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVBAQKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVBAQKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:10:55 -0500
Received: from scrat.cs.umu.se ([130.239.40.18]:11913 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S262057AbVBAQKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:10:49 -0500
Date: Tue, 1 Feb 2005 17:10:46 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] arch/i386/kernel/apic.c Kill a sparse warning
Message-ID: <20050201161046.GD155@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch replaces a K&R-style function definition with its
ANSI counterpart.


diff -u linux-bk/arch/i386/kernel/apic.c linux/arch/i386/kernel/apic.c
--- linux-bk/arch/i386/kernel/apic.c	2005-01-29 03:14:14.000000000 +0100
+++ linux/arch/i386/kernel/apic.c	2005-01-29 03:16:35.000000000 +0100
@@ -518,8 +518,7 @@
  * disable it down before re-entering the BIOS on shutdown.
  * Otherwise the BIOS may get confused and not power-off.
  */
-void
-lapic_shutdown()
+void lapic_shutdown(void)
 {
 	if (!cpu_has_apic || !enabled_via_apicbase)
 		return;


-- 
Peter Hagervall......................email: hager@cs.umu.se
Department of Computing Science........tel: +46(0)90 786 7018
University of Umeå, SE-901 87 Umeå.....fax: +46(0)90 786 6126
