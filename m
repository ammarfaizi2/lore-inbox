Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTFJSmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTFJSlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:41:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47023 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264060AbTFJShe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:34 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709693416@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709691608@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1377, 2003/06/09 16:20:11-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/i810_audio.c


 sound/oss/i810_audio.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Tue Jun 10 11:17:31 2003
+++ b/sound/oss/i810_audio.c	Tue Jun 10 11:17:31 2003
@@ -3449,9 +3449,6 @@
 
 static int __init i810_init_module (void)
 {
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
-
 	printk(KERN_INFO "Intel 810 + AC97 Audio, version "
 	       DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
 

