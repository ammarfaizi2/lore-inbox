Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTFJSiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTFJShb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60065 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262763AbTFJSgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709691726@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709693416@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1378, 2003/06/09 16:20:35-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/ite8172.c


 sound/oss/ite8172.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/sound/oss/ite8172.c b/sound/oss/ite8172.c
--- a/sound/oss/ite8172.c	Tue Jun 10 11:17:26 2003
+++ b/sound/oss/ite8172.c	Tue Jun 10 11:17:26 2003
@@ -1940,8 +1940,6 @@
 
 static int __init init_it8172(void)
 {
-    if (!pci_present())   /* No PCI bus in this machine! */
-	return -ENODEV;
     printk("version v0.26 time " __TIME__ " " __DATE__ "\n");
     return pci_module_init(&it8172_driver);
 }

