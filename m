Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUHISzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUHISzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUHISyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:54:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20104 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266867AbUHISvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:51:47 -0400
Date: Mon, 9 Aug 2004 14:50:49 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: HPT IDE
Message-ID: <20040809185049.GA5006@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some changes got merged but one other is needed. Not sure where it escaped
I guess I missed it originally


diff -u --recursive --new-file --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/ide/pci/hpt366.h linux-2.6.8-rc2/drivers/ide/pci/hpt366.h
--- linux.vanilla-2.6.8-rc2/drivers/ide/pci/hpt366.h	2004-07-27 19:21:37.000000000 +0100
+++ linux-2.6.8-rc2/drivers/ide/pci/hpt366.h	2004-07-28 21:53:14.000000000 +0100
@@ -470,6 +470,15 @@
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+	},{	/* 5 */
+		.name		= "HPT372N",
+		.init_setup	= init_setup_hpt37x,
+		.init_chipset	= init_chipset_hpt366,
+		.init_hwif	= init_hwif_hpt366,
+		.init_dma	= init_dma_hpt366,
+		.channels	= 2,	/* 4 */
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
 	}
 };
 
