Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVA3Ujq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVA3Ujq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 15:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVA3Ujp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 15:39:45 -0500
Received: from mail.dif.dk ([193.138.115.101]:4815 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261778AbVA3Ujn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 15:39:43 -0500
Date: Sun, 30 Jan 2005 21:43:05 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: isdn4linux <isdn4linux@listserv.isdn4linux.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       Karsten Keil <keil@isdn4linux.de>, Karsten Keil <kkeil@suse.de>
Subject: [PATCH] remove unused label and obsolete preprocessor gunk from
 hisax
Message-ID: <Pine.LNX.4.62.0501302133220.2731@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here's a patch to remove an unused label and some obsolete preprocessor 
magic around it. Thus killing this warning:
drivers/isdn/hisax/hisax_fcpcipnp.c:1014: warning: label `out_unregister_isapnp' defined but not used
 Please apply.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc2-bk7-orig/drivers/isdn/hisax/hisax_fcpcipnp.c	2005-01-22 21:59:37.000000000 +0100
+++ linux-2.6.11-rc2-bk7/drivers/isdn/hisax/hisax_fcpcipnp.c	2005-01-30 20:04:00.000000000 +0100
@@ -1010,12 +1010,6 @@ static int __init hisax_fcpcipnp_init(vo
 #endif
 	return 0;
 
-#if !defined(CONFIG_HOTPLUG) || defined(MODULE)
- out_unregister_isapnp:
-#ifdef __ISAPNP__
-	pnp_unregister_driver(&fcpnp_driver);
-#endif
-#endif
  out_unregister_pci:
 	pci_unregister_driver(&fcpci_driver);
  out:



