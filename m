Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbULYMfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbULYMfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 07:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULYMfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 07:35:54 -0500
Received: from aun.it.uu.se ([130.238.12.36]:64730 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261285AbULYMfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 07:35:50 -0500
Date: Sat, 25 Dec 2004 13:35:41 +0100 (MET)
Message-Id: <200412251235.iBPCZfpU010975@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.6.10] fix non prototype-form definition of lapic_shutdown()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for the non prototype-form definition of
lapic_shutdown() added recently.

/Mikael

diff -rupN linux-2.6.10/arch/i386/kernel/apic.c linux-2.6.10.i386-apic-cleanup/arch/i386/kernel/apic.c
--- linux-2.6.10/arch/i386/kernel/apic.c	2004-12-25 12:16:17.000000000 +0100
+++ linux-2.6.10.i386-apic-cleanup/arch/i386/kernel/apic.c	2004-12-25 12:37:06.000000000 +0100
@@ -519,7 +519,7 @@ void __init setup_local_APIC (void)
  * Otherwise the BIOS may get confused and not power-off.
  */
 void
-lapic_shutdown()
+lapic_shutdown(void)
 {
 	if (!cpu_has_apic || !enabled_via_apicbase)
 		return;
