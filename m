Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTFJT3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTFJSkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:40:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:35205 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264075AbTFJShg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:36 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709702876@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709701210@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1380, 2003/06/09 16:21:33-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/nec_vrc5477.c


 sound/oss/nec_vrc5477.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/sound/oss/nec_vrc5477.c b/sound/oss/nec_vrc5477.c
--- a/sound/oss/nec_vrc5477.c	Tue Jun 10 11:17:06 2003
+++ b/sound/oss/nec_vrc5477.c	Tue Jun 10 11:17:06 2003
@@ -2002,8 +2002,6 @@
 
 static int __init init_vrc5477_ac97(void)
 {
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
 	printk("Vrc5477 AC97 driver: version v0.2 time " __TIME__ " " __DATE__ " by Jun Sun\n");
 	return pci_module_init(&vrc5477_ac97_driver);
 }

