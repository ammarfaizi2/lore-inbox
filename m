Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268489AbTBWPL5>; Sun, 23 Feb 2003 10:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268487AbTBWPKT>; Sun, 23 Feb 2003 10:10:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8465 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268483AbTBWPKO>; Sun, 23 Feb 2003 10:10:14 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] [2/6] Remove unused "dev" argument from cb_setup_cis_mem
Message-Id: <20020223151802@raistlin.arm.linux.org.uk>
References: <20020223151801@raistlin.arm.linux.org.uk>
In-Reply-To: <20020223151801@raistlin.arm.linux.org.uk>
Date: Sun, 23 Feb 2003 15:20:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.62, but applies cleanly.

Subject: [2/6] Remove unused "dev" argument from cb_setup_cis_mem
cb_setup_cis_mem doesn't reference the pci device.  Remove this unused
argument.

 drivers/pcmcia/cardbus.c |    4 ++--
 1 files changed, 2 insertions, 2 deletions

diff -ur -x sa11* -x Kconfig -x Makefile orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Sun Feb 23 12:39:27 2003
+++ linux/drivers/pcmcia/cardbus.c	Sun Feb 23 12:17:52 2003
@@ -146,7 +146,7 @@
 	}
 }
 
-static int cb_setup_cis_mem(socket_info_t * s, struct pci_dev *dev, struct resource *res)
+static int cb_setup_cis_mem(socket_info_t * s, struct resource *res)
 {
 	unsigned int start, size;
 
@@ -201,7 +201,7 @@
 	if (!res->flags)
 		goto fail;
 
-	if (cb_setup_cis_mem(s, dev, res) != 0)
+	if (cb_setup_cis_mem(s, res) != 0)
 		goto fail;
 
 	if (space == 7) {
