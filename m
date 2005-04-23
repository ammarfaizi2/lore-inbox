Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVDWSeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVDWSeu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDWSet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:34:49 -0400
Received: from smtp.evc.net ([212.95.66.37]:16063 "EHLO smtp.evc.net")
	by vger.kernel.org with ESMTP id S261668AbVDWSea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:34:30 -0400
Subject: [PATCH] radeon : fix resuming printk, kernel 2.6.11-7
From: Victor STINNER <victor.stinner@haypocalc.com>
Reply-To: victor.stinner@haypocalc.com
To: Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Bv7m2KGS6uODy7Zr1P5c"
Date: Sat, 23 Apr 2005 20:34:36 +0200
Message-Id: <1114281276.21753.1.camel@haypopc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-AV-Checked: clean on smtp.evc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Bv7m2KGS6uODy7Zr1P5c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

My patch remove a warning around Radeaon ATY driver.

I hope that this warning is not yet removed. If yes, where can I see the
lastest version of a file from Linux Kernel ? I used 
http://ehlo.org/~kay/gitweb.pl/linux-2.6/

Bye, Haypo


--=-Bv7m2KGS6uODy7Zr1P5c
Content-Disposition: attachment; filename=radeon_resume.patch
Content-Type: text/x-patch; name=radeon_resume.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- drivers/video/aty/radeon_pm.c.old	2005-04-23 19:47:30.000000000 +0200
+++ drivers/video/aty/radeon_pm.c	2005-04-23 19:47:39.000000000 +0200
@@ -2606,7 +2606,7 @@
 		acquire_console_sem();
 
 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
-	       pci_name(pdev), pdev->dev.power.power_state);
+	       pci_name(pdev), pdev->dev.power.power_state.event);
 
 
 	if (pci_enable_device(pdev)) {

--=-Bv7m2KGS6uODy7Zr1P5c--

