Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVDQUWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVDQUWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDQUTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:19:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21523 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261483AbVDQUQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:16:25 -0400
Date: Sun, 17 Apr 2005 22:16:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/rio/rio_linux.c: make a variable static
Message-ID: <20050417201624.GP3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/char/rio/rio_linux.c.old	2005-04-17 18:18:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/rio/rio_linux.c	2005-04-17 18:18:47.000000000 +0200
@@ -221,7 +221,7 @@
 /* Set the mask to all-ones. This alas, only supports 32 interrupts. 
    Some architectures may need more. -- Changed to LONG to
    support up to 64 bits on 64bit architectures. -- REW 20/06/99 */
-long rio_irqmask = -1;
+static long rio_irqmask = -1;
 
 MODULE_AUTHOR("Rogier Wolff <R.E.Wolff@bitwizard.nl>, Patrick van de Lageweg <patrick@bitwizard.nl>");
 MODULE_DESCRIPTION("RIO driver");

