Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTFJVfC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFJShF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21166 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262528AbTFJSgt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709701210@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709691726@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1379, 2003/06/09 16:21:01-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/maestro3.c


 sound/oss/maestro3.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/sound/oss/maestro3.c b/sound/oss/maestro3.c
--- a/sound/oss/maestro3.c	Tue Jun 10 11:17:16 2003
+++ b/sound/oss/maestro3.c	Tue Jun 10 11:17:16 2003
@@ -2936,9 +2936,6 @@
 
 static int __init m3_init_module(void)
 {
-    if (!pci_present())   /* No PCI bus in this machine! */
-        return -ENODEV;
-
     printk(KERN_INFO PFX "version " DRIVER_VERSION " built at " __TIME__ " " __DATE__ "\n");
 
     if (register_reboot_notifier(&m3_reboot_nb)) {

