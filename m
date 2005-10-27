Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVJ0I1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVJ0I1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbVJ0I1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:27:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41910 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964996AbVJ0I1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:27:19 -0400
From: Andi Kleen <ak@suse.de>
To: vojtech@suse.cz
Subject: [PATCH] Disable the most annoying printk in the kernel
Date: Thu, 27 Oct 2005 10:26:10 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510271026.10913.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove most useless printk in the world

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/drivers/input/keyboard/atkbd.c
===================================================================
--- linux/drivers/input/keyboard/atkbd.c
+++ linux/drivers/input/keyboard/atkbd.c
@@ -328,7 +328,6 @@ static irqreturn_t atkbd_interrupt(struc
 			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
-			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.
\n", serio->phys);
 			goto out;
 	}
 
