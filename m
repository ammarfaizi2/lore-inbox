Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265244AbUFAVoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUFAVoC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUFAVoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:44:02 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:64640 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265244AbUFAVnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:43:55 -0400
Date: Tue, 1 Jun 2004 23:43:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jgarzik@pobox.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [trivial] no mili-bits-per-second for via-rhine
Message-ID: <20040601214345.GA32700@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

via-rhine claims to support 100 mili-bits-per-second mode and one
place and 100 mega-bit-second mode ("100 mega-bit-seconds of storage
for only $1?"). This cleans it up.

								Pavel

--- tmp/linux/drivers/net/via-rhine.c	2004-05-20 23:08:19.000000000 +0200
+++ linux/drivers/net/via-rhine.c	2004-05-20 23:11:26.000000000 +0200
@@ -863,12 +863,12 @@
 		if (np->default_port & 0x330) {
 			/* FIXME: shouldn't someone check this variable? */
 			/* np->medialock = 1; */
-			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
+			printk(KERN_INFO "  Forcing %dMbps %s-duplex operation.\n",
 				   (option & 0x300 ? 100 : 10),
 				   (option & 0x220 ? "full" : "half"));
 			if (np->mii_cnt)
 				mdio_write(dev, np->phys[0], MII_BMCR,
-						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
+						   ((option & 0x300) ? 0x2000 : 0) |  /* 100Mbps? */
 						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
 		}
 	}

-- 
934a471f20d6580d5aad759bf0d97ddc
