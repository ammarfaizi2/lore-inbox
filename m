Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVCYB66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVCYB66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVCYAtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:49:16 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:35778 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261309AbVCYASM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:18:12 -0500
Date: Fri, 25 Mar 2005 01:23:17 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Andi Kleen <ak@muc.de>
Cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11.5] atkbd: suppress debug output (was: printk with
 anti-cluttering-feature)
In-Reply-To: <m1is3l3v25.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0503250111240.4258@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <m1is3l3v25.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Andi Kleen wrote:
> Bodo Eggert <7eggert@gmx.de> writes:

> > atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
> >  (I'm using a keyboard switch and a IBM PS/2 keyboard)
> 
> This one should be just taken out. It is as far as I can figure out
> completely useless and happens on most machines.

Signed-off-by: Bodo Eggert <7eggert@gmx.de>

--- linux-2.6.11/drivers/input/keyboard/atkbd.c	2005-03-20 21:50:52.000000000 +0100
+++ linux-2.6.11.new/drivers/input/keyboard/atkbd.c	2005-03-25 01:06:50.000000000 +0100
@@ -320,7 +320,9 @@ static irqreturn_t atkbd_interrupt(struc
 			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
+#ifdef ATKBD_DEBUG
 			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
+#endif
 			goto out;
 	}
 
-- 
If you can't remember, then the claymore IS pointed at you. 

Friﬂ, Spammer: billing@mclchnfa.info nkFWbu@volksgemeinschaft.org
 sparing@fuoje43.com w@7eggert.dyndns.org service@xsalez.org
