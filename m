Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUBQAph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 19:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbUBQAph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 19:45:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:63905 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263903AbUBQApf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 19:45:35 -0500
Subject: [PATCH] Fix ppc compile problem with gcc 3.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076978685.1046.130.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 11:44:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've just been reported this one, a stupid redefinition 
extern/static in prep_pci. This patch fixes it.

Ben.

===== arch/ppc/platforms/prep_pci.c 1.22 vs edited =====
--- 1.22/arch/ppc/platforms/prep_pci.c	Tue Sep 16 06:59:05 2003
+++ edited/arch/ppc/platforms/prep_pci.c	Tue Feb 17 11:41:19 2004
@@ -1171,8 +1171,6 @@
 prep_pcibios_fixup(void)
 {
         struct pci_dev *dev = NULL;
-        extern unsigned char *Motherboard_map;
-        extern unsigned char *Motherboard_routes;
 
 	prep_route_pci_interrupts();
 


