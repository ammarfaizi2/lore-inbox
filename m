Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbTFSD7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTFSD5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:57:09 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:55428 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265386AbTFSDz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:55:58 -0400
Date: Wed, 18 Jun 2003 23:46:50 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234650.GI333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618234418.GC333@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1420  -> 1.1421 
#	drivers/pnp/isapnp/core.c	1.37    -> 1.38   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1421
# [PNP] Remove some leftover resource config options in isapnp
# 
# Must have missed it earlier, but the pci module parameter is not needed.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Wed Jun 18 23:01:25 2003
+++ b/drivers/pnp/isapnp/core.c	Wed Jun 18 23:01:25 2003
@@ -55,7 +55,6 @@
 int isapnp_disable;			/* Disable ISA PnP */
 int isapnp_rdp;				/* Read Data Port */
 int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
-int isapnp_skip_pci_scan;		/* skip PCI resource scanning */
 int isapnp_verbose = 1;			/* verbose mode */
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
@@ -67,8 +66,6 @@
 MODULE_PARM(isapnp_reset, "i");
 MODULE_PARM_DESC(isapnp_reset, "ISA Plug & Play reset all cards");
 MODULE_PARM(isapnp_allow_dma0, "i");
-MODULE_PARM(isapnp_skip_pci_scan, "i");
-MODULE_PARM_DESC(isapnp_skip_pci_scan, "ISA Plug & Play skip PCI resource scanning");
 MODULE_PARM(isapnp_verbose, "i");
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
@@ -1175,7 +1172,6 @@
 {
 	(void)((get_option(&str,&isapnp_rdp) == 2) &&
 	       (get_option(&str,&isapnp_reset) == 2) &&
-	       (get_option(&str,&isapnp_skip_pci_scan) == 2) &&
 	       (get_option(&str,&isapnp_verbose) == 2));
 	return 1;
 }
