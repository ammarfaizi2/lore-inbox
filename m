Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbSLKWcC>; Wed, 11 Dec 2002 17:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbSLKWcC>; Wed, 11 Dec 2002 17:32:02 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6916 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267342AbSLKWcA>;
	Wed, 11 Dec 2002 17:32:00 -0500
Date: Tue, 10 Dec 2002 22:57:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: hp100: make it compile with debugging
Message-ID: <20021210215757.GA527@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is neccessary if you want hp100 to compile with debugging, please
apply.

								Pavel

--- clean/drivers/net/hp100.c	2002-11-23 19:55:22.000000000 +0100
+++ linux-swsusp/drivers/net/hp100.c	2002-12-09 21:19:48.000000000 +0100
@@ -2096,6 +2094,7 @@
 	struct hp100_private *lp = (struct hp100_private *) dev->priv;
 
 #ifdef HP100_DEBUG_B
+	int ioaddr = dev->base_addr;
 	hp100_outw(0x4216, TRACE);
 	printk("hp100: %s: misc_interrupt\n", dev->name);
 #endif

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
