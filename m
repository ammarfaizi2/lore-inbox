Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTFJTym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTFJShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:5532 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262547AbTFJSgx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270970236@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709702876@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1381, 2003/06/09 16:21:56-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/rme96xx.c


 sound/oss/rme96xx.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
--- a/sound/oss/rme96xx.c	Tue Jun 10 11:16:56 2003
+++ b/sound/oss/rme96xx.c	Tue Jun 10 11:16:56 2003
@@ -1093,9 +1093,6 @@
 
 static int __init init_rme96xx(void)
 {
-  
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
 	printk(KERN_INFO RME_MESS" version "RMEVERSION" time " __TIME__ " " __DATE__ "\n");
 	devices = ((devices-1) & RME96xx_MASK_DEVS) + 1;
 	printk(KERN_INFO RME_MESS" reserving %d dsp device(s)\n",devices);

