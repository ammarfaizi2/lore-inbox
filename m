Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTFJVDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFJVDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:03:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:175 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263859AbTFJShL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709693825@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709693478@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1372, 2003/06/09 16:14:56-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/cs4281/cs4281m.c


 sound/oss/cs4281/cs4281m.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
--- a/sound/oss/cs4281/cs4281m.c	Tue Jun 10 11:17:59 2003
+++ b/sound/oss/cs4281/cs4281m.c	Tue Jun 10 11:17:59 2003
@@ -4484,11 +4484,6 @@
 	int rtn = 0;
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO 
 		"cs4281: cs4281_init_module()+ \n"));
-	if (!pci_present()) {	/* No PCI bus in this machine! */
-		CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO
-			"cs4281: cs4281_init_module()- no pci bus found\n"));
-		return -ENODEV;
-	}
 	printk(KERN_INFO "cs4281: version v%d.%02d.%d time " __TIME__ " "
 	       __DATE__ "\n", CS4281_MAJOR_VERSION, CS4281_MINOR_VERSION,
 	       CS4281_ARCH);

