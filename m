Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263828AbTCUS4O>; Fri, 21 Mar 2003 13:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263809AbTCUSzU>; Fri, 21 Mar 2003 13:55:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33156
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263820AbTCUSyC>; Fri, 21 Mar 2003 13:54:02 -0500
Date: Fri, 21 Mar 2003 20:09:18 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212009.h2LK9II4026286@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix incorrect bracketing in maestro
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/maestro.c linux-2.5.65-ac2/sound/oss/maestro.c
--- linux-2.5.65/sound/oss/maestro.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/maestro.c	2003-03-06 23:19:08.000000000 +0000
@@ -3367,7 +3367,7 @@
 	/* check to see if we have a capabilities list in
 		the config register */
 	pci_read_config_word(pcidev, PCI_STATUS, &w);
-	if(! w & PCI_STATUS_CAP_LIST) return 0;
+	if(!(w & PCI_STATUS_CAP_LIST)) return 0;
 
 	/* walk the list, starting at the head. */
 	pci_read_config_byte(pcidev,PCI_CAPABILITY_LIST,&next);
