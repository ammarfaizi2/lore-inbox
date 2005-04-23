Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVDWSPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVDWSPo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDWSPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:15:44 -0400
Received: from smtp.evc.net ([212.95.66.37]:60346 "EHLO smtp.evc.net")
	by vger.kernel.org with ESMTP id S261647AbVDWSPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:15:37 -0400
Subject: [PATCH] ati-agp : remove warning in agp_ati_suspend, kernel
	2.6.11-7
From: Victor STINNER <victor.stinner@haypocalc.com>
Reply-To: victor.stinner@haypocalc.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-4A2FZ6GhUpxSShHGdbvz"
Date: Sat, 23 Apr 2005 20:15:40 +0200
Message-Id: <1114280140.20958.5.camel@haypopc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-AV-Checked: clean on smtp.evc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4A2FZ6GhUpxSShHGdbvz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

My patch remove a warning around AGP ATI driver.

I hope that this warning is not yet removed. If yes, where can I see the
lastest version of a file from Linux Kernel ? I used 
http://ehlo.org/~kay/gitweb.pl/linux-2.6/

Bye, Haypo

--=-4A2FZ6GhUpxSShHGdbvz
Content-Disposition: attachment; filename=ati-agp_suspend.patch
Content-Type: text/x-patch; name=ati-agp_suspend.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- drivers/char/agp/ati-agp.c.old	2005-04-23 19:36:23.000000000 +0200
+++ drivers/char/agp/ati-agp.c	2005-04-23 19:38:05.000000000 +0200
@@ -508,7 +508,7 @@
 
 #ifdef CONFIG_PM
 
-static int agp_ati_suspend(struct pci_dev *pdev, u32 state)
+static int agp_ati_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state (pdev);
 	pci_set_power_state (pdev, 3);

--=-4A2FZ6GhUpxSShHGdbvz--

