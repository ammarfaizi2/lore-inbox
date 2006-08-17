Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWHQNsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWHQNsz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWHQN2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:14 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:6306 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964883AbWHQN2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:00 -0400
Date: Thu, 17 Aug 2006 13:28:20 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Neela.Kolli@engenio.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC][PATCH 38/75] scsi: drivers/scsi/megaraid.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132820.38.NivloR4613.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/megaraid.c linux-work2/drivers/scsi/megaraid.c
--- linux-work-clean/drivers/scsi/megaraid.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/scsi/megaraid.c	2006-08-17 05:21:04.000000000 +0200
@@ -5078,7 +5078,7 @@ static int __init megaraid_init(void)
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
-	error = pci_module_init(&megaraid_pci_driver);
+	error = pci_register_driver(&megaraid_pci_driver);
 	if (error) {
 #ifdef CONFIG_PROC_FS
 		remove_proc_entry("megaraid", &proc_root);
