Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVCVCGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVCVCGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVCVCGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:06:34 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:20875 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262330AbVCVBfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:36 -0500
Message-Id: <20050322013500.055204000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:15 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <c.lucas@ifrance.com>,
       Domen Puncer <domen@coderock.org>
Content-Disposition: inline; filename=dvb-janitor-pci-init.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 42/48] convert from pci_module_init to pci_register_driver
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From : http://kerneljanitors.org/TODO
o convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 b2c2/skystar2.c |    2 +-
 bt8xx/bt878.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/b2c2/skystar2.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c	2005-03-22 00:28:10.000000000 +0100
@@ -2629,7 +2629,7 @@ static struct pci_driver skystar2_pci_dr
 
 static int skystar2_init(void)
 {
-	return pci_module_init(&skystar2_pci_driver);
+	return pci_register_driver(&skystar2_pci_driver);
 }
 
 static void skystar2_cleanup(void)
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/bt878.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/bt8xx/bt878.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/bt878.c	2005-03-22 00:28:10.000000000 +0100
@@ -563,7 +563,7 @@ static int bt878_init_module(void)
 	/* later we register inside of bt878_find_audio_dma()
 	 * because we may want to ignore certain cards */
 	bt878_pci_driver_registered = 1;
-	return pci_module_init(&bt878_pci_driver);
+	return pci_register_driver(&bt878_pci_driver);
 }
 
 static void bt878_cleanup_module(void)

--

