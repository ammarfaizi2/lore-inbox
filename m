Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTFJT3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTFJSja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:39:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30365 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264061AbTFJShe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:34 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709703278@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709701338@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1384, 2003/06/09 16:23:14-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/trident.c


 sound/oss/trident.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Tue Jun 10 11:16:21 2003
+++ b/sound/oss/trident.c	Tue Jun 10 11:16:21 2003
@@ -4385,9 +4385,6 @@
 
 static int __init trident_init_module (void)
 {
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
-
 	printk(KERN_INFO "Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro "
 	       "5050 PCI Audio, version " DRIVER_VERSION ", " 
 	       __TIME__ " " __DATE__ "\n");

