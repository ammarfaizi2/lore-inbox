Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTFJVCP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTFJShL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53409 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262530AbTFJSgw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:52 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709701338@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270970872@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1383, 2003/06/09 16:22:44-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/sonicvibes.c


 sound/oss/sonicvibes.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
--- a/sound/oss/sonicvibes.c	Tue Jun 10 11:16:35 2003
+++ b/sound/oss/sonicvibes.c	Tue Jun 10 11:16:35 2003
@@ -2723,8 +2723,6 @@
  
 static int __init init_sonicvibes(void)
 {
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
 	printk(KERN_INFO "sv: version v0.31 time " __TIME__ " " __DATE__ "\n");
 #if 0
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))

