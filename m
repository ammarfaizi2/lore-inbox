Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVCVDpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVCVDpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVCVCY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:24:27 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:36490 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262271AbVCVBeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:20 -0500
Message-Id: <20050322013454.833635000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:37 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-skystar2-pci.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 04/48] skystar2: remove duplicate pci_release_region()
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicated pci_release_region() etc.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 skystar2.c |    4 ----
 1 files changed, 4 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/b2c2/skystar2.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c	2005-03-22 00:14:40.000000000 +0100
@@ -1996,10 +1996,6 @@ static void driver_halt(struct pci_dev *
 	free_adapter_object(adapter);
 
 	pci_set_drvdata(pdev, NULL);
-
-	pci_disable_device(pdev);
-	pci_release_region(pdev, 1);
-	pci_release_region(pdev, 0);
 }
 
 static int dvb_start_feed(struct dvb_demux_feed *dvbdmxfeed)

--

