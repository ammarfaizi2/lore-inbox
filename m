Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTHURbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbTHURa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:30:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:11206 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262839AbTHURa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:30:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870703478@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870703538@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:10 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1285.1.5, 2003/08/20 16:59:06-07:00, greg@kroah.com

FB: fix broken tridentfb.c driver due to device.name change.


 drivers/video/tridentfb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	Thu Aug 21 10:20:41 2003
+++ b/drivers/video/tridentfb.c	Thu Aug 21 10:20:41 2003
@@ -1129,7 +1129,7 @@
 		return -1;
 	}
 
-	output("%s board found\n", dev->dev.name);
+	output("%s board found\n", pci_name(dev));
 #if 0	
 	output("Trident board found : mem = %X,io = %X, mem_v = %X, io_v = %X\n",
 		tridentfb_fix.smem_start, tridentfb_fix.mmio_start, fb_info.screen_base, default_par.io_virt);

