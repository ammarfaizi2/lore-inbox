Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUJ1KRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUJ1KRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUJ1KPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:15:51 -0400
Received: from sd291.sivit.org ([194.146.225.122]:49046 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262884AbUJ1KIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:08:02 -0400
Date: Thu, 28 Oct 2004 12:09:28 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 6/8] sonypi: don't suppose the bluetooth subsystem is initialy off
Message-ID: <20041028100928.GG3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2196, 2004-10-28 10:40:18+02:00, stelian@popies.net
  sonypi: don't suppose the bluetooth subsystem is initialy off,
  	  leave the choice to the user.

  Signed-off-by: Stelian Pop <stelian@popies.net>
  
===================================================================

 sonypi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-10-28 11:13:37 +02:00
+++ b/drivers/char/sonypi.c	2004-10-28 11:13:37 +02:00
@@ -754,7 +754,7 @@
 
 	init_waitqueue_head(&sonypi_device.fifo_proc_list);
 	init_MUTEX(&sonypi_device.lock);
-	sonypi_device.bluetooth_power = 0;
+	sonypi_device.bluetooth_power = -1;
 	
 	if (pcidev && pci_enable_device(pcidev)) {
 		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
