Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUEJXQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUEJXQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUEJXQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:16:44 -0400
Received: from p508B5AFA.dip.t-dialin.net ([80.139.90.250]:1626 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S263079AbUEJXOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:14:37 -0400
Date: Tue, 11 May 2004 01:14:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 8250_pci.c build fix
Message-ID: <20040510231426.GA9104@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes between 2.6.6-rc3 and 2.6.6 broke static compliation of
8250_pci.c.  Obvious fix below.

  Ralf

Index: drivers/serial/8250_pci.c
===================================================================
RCS file: /home/cvs/linux/drivers/serial/8250_pci.c,v
retrieving revision 1.18
diff -u -r1.18 8250_pci.c
--- drivers/serial/8250_pci.c	10 May 2004 14:25:34 -0000	1.18
+++ drivers/serial/8250_pci.c	10 May 2004 23:09:21 -0000
@@ -704,7 +704,7 @@
 		.subdevice	= PCI_SUBDEVICE_ID_OCTPRO232,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= sbs_exit
+		.exit		= __devexit_p(sbs_exit)
 	},
 	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 422
@@ -716,7 +716,7 @@
 		.subdevice	= PCI_SUBDEVICE_ID_OCTPRO422,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= sbs_exit
+		.exit		= __devexit_p(sbs_exit)
 	},
 	/*
 	 * SBS Technologies, Inc., P-Octal 232
@@ -728,7 +728,7 @@
 		.subdevice	= PCI_SUBDEVICE_ID_POCTAL232,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= sbs_exit
+		.exit		= __devexit_p(sbs_exit)
 	},
 	/*
 	 * SBS Technologies, Inc., P-Octal 422
@@ -740,7 +740,7 @@
 		.subdevice	= PCI_SUBDEVICE_ID_POCTAL422,
 		.init		= sbs_init,
 		.setup		= sbs_setup,
-		.exit		= sbs_exit
+		.exit		= __devexit_p(sbs_exit)
 	},
 
 	/*
