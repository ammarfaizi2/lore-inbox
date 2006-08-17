Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWHQNbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWHQNbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWHQN3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:23 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:32690 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964932AbWHQN3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:14 -0400
Date: Thu, 17 Aug 2006 13:29:41 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: kurt@garloff.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC][PATCH 67/75] scsi: drivers/scsi/tmscsim.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132941.67.ZRpalO5377.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/tmscsim.c linux-work2/drivers/scsi/tmscsim.c
--- linux-work-clean/drivers/scsi/tmscsim.c	2006-08-16 22:41:01.000000000 +0200
+++ linux-work2/drivers/scsi/tmscsim.c	2006-08-17 05:21:14.000000000 +0200
@@ -2670,7 +2670,7 @@ static int __init dc390_module_init(void
 		printk (KERN_INFO "DC390: Using safe settings.\n");
 	}
 
-	return pci_module_init(&dc390_driver);
+	return pci_register_driver(&dc390_driver);
 }
 
 static void __exit dc390_module_exit(void)
