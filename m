Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbULFU74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbULFU74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbULFU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:59:56 -0500
Received: from math.ut.ee ([193.40.5.125]:12693 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261652AbULFU7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:59:03 -0500
Date: Mon, 6 Dec 2004 22:59:02 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "unsigned<0" warning
Message-ID: <Pine.SOC.4.61.0412062257130.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "comparison of unsigned expression < 0 is always false"
occuring on line 711

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/drivers/ide/setup-pci.c	2004-11-30 19:43:52.000000000 +0000
+++ b/drivers/ide/setup-pci.c	2004-12-06 19:26:57.000000000 +0000
@@ -708,8 +708,7 @@
  	} else {
  		if (d->init_chipset)
  		{
-			if(d->init_chipset(dev, d->name) < 0)
-				return index;
+			d->init_chipset(dev, d->name)
  		}
  		if (noisy)
  #ifdef __sparc__
