Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTFJSit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTFJShn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:16028 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262818AbTFJSg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:56 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270969401@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709691006@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1374, 2003/06/09 16:18:56-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/es1370.c


 sound/oss/es1370.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/sound/oss/es1370.c b/sound/oss/es1370.c
--- a/sound/oss/es1370.c	Tue Jun 10 11:17:49 2003
+++ b/sound/oss/es1370.c	Tue Jun 10 11:17:49 2003
@@ -2739,8 +2739,6 @@
 
 static int __init init_es1370(void)
 {
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
 	printk(KERN_INFO "es1370: version v0.38 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1370_driver);
 }

