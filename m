Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUHPMk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUHPMk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbUHPMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:40:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41102 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267576AbUHPMkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:40:55 -0400
Date: Mon, 16 Aug 2004 08:39:53 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: Phil Copeland discovered ide-pnp hadn't been updated
Message-ID: <20040816123953.GA26430@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- drivers/ide/ide-pnp.c~	2004-08-16 13:36:35.531635600 +0100
+++ drivers/ide/ide-pnp.c	2004-08-16 13:36:35.531635600 +0100
@@ -57,7 +57,7 @@
 {
 	ide_hwif_t *hwif = pnp_get_drvdata(dev);
 	if (hwif) {
-		ide_unregister(hwif->index);
+		ide_unregister_hwif(hwif);
 	} else
 		printk(KERN_ERR "idepnp: Unable to remove device, please report.\n");
 }

Signed-off-by: Alan Cox


