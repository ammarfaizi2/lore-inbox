Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVBZUFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVBZUFU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 15:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVBZUFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 15:05:20 -0500
Received: from 83-70-160-152.b-ras1.prp.dublin.eircom.net ([83.70.160.152]:9857
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261263AbVBZUFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 15:05:15 -0500
Date: Sat, 26 Feb 2005 20:06:28 +0000 (GMT)
From: Telemaque Ndizihiwe <telendiz@eircom.net>
X-X-Sender: telendiz@localhost.localdomain
To: kai.germaschewski@gmx.de, kkeil@suse.de
cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] Removes unused label from /drivers/isdn/hisax/hisax_fcpcipnp.c
Message-ID: <Pine.LNX.4.62.0502261925020.11264@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This Patch removes (in kernel 2.6.10) an unused label (fixes compiler WARNING)
and a function (inside a preprocessor directive) that is never called.

Signed-off- by: Telemaque Ndizihiwe <telendiz@eircom.net>


--- linux-2.6.10/drivers/isdn/hisax/hisax_fcpcipnp.c.orig	2005-02-26 19:16:06.030150400 +0000
+++ linux-2.6.10/drivers/isdn/hisax/hisax_fcpcipnp.c	2005-02-26 19:18:01.023668728 +0000
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
