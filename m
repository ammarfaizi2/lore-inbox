Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUE3IcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUE3IcC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 04:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUE3IcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 04:32:02 -0400
Received: from verein.lst.de ([212.34.189.10]:51858 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261723AbUE3IcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 04:32:00 -0400
Date: Sun, 30 May 2004 10:31:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Lowered priority of "too many keys" message in atkbd
Message-ID: <20040530083126.GA30916@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, vojtech@suse.cz,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from the Debian kernel package and I think it's valid
because this error doesn't cause any kind of malfunction of the system.


--- linux/drivers/input/keyboard/atkbd.c	2004-04-05 19:49:28.000000000 +1000
+++ linux/drivers/input/keyboard/atkbd.c	2004-04-06 19:55:38.000000000 +1000
@@ -284,7 +284,7 @@
 			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
-			printk(KERN_WARNING "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
+			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
 			goto out;
 	}
 
