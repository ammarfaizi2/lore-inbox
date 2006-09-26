Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWIZQNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWIZQNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWIZQNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:13:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63195 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932337AbWIZQNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:13:20 -0400
Subject: [PATCH] libata: tighten rules for legacy dependancies
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 17:37:22 +0100
Message-Id: <1159288642.11049.253.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy and QDI drivers are ISA/VLB bus [we don't have a VLB define
but ISA will do nicely].

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/Kconfig linux-2.6.18-mm1/drivers/ata/Kconfig
--- linux.vanilla-2.6.18-mm1/drivers/ata/Kconfig	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/Kconfig	2006-09-25 16:03:45.000000000 +0100
@@ -317,7 +317,7 @@
 
 config PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	depends on ISA && EXPERIMENTAL
 	help
 	  This option enables support for ISA/VLB bus legacy PATA
 	  ports and allows them to be accessed via the new ATA layer.
@@ -406,6 +415,7 @@
 
 config PATA_QDI
 	tristate "QDI VLB PATA support"
+	depends on ISA
 	help
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
 

