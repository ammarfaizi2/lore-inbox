Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265270AbUFAWlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUFAWlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUFAWkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:40:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265270AbUFAWac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:32 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [2/10]
Date: Wed, 2 Jun 2004 00:17:42 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406020016.55820.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: fix for generic IDE PCI module

Extracted from the Debian kernel package.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/Kconfig~ide_pci_generic_fix drivers/ide/Kconfig
--- linux-2.6.7-rc2-bk2/drivers/ide/Kconfig~ide_pci_generic_fix	2004-06-01 20:58:34.815528864 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/Kconfig	2004-06-01 21:03:15.515855928 +0200
@@ -387,8 +387,8 @@ config BLK_DEV_OFFBOARD
 	  If in doubt, say N.
 
 config BLK_DEV_GENERIC
-	bool "Generic PCI IDE Chipset Support"
-	depends on PCI && BLK_DEV_IDEPCI
+	tristate "Generic PCI IDE Chipset Support"
+	depends on BLK_DEV_IDEPCI
 
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support (EXPERIMENTAL)"

_

