Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUBBVDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUBBTqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:46:12 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:16469 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265921AbUBBTpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:45:13 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:45:12 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 12/42]
Message-ID: <20040202194512.GL6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


include/linux/autoconf.h:2070:1: warning: "CONFIG_SERIAL_SHARE_IRQ" redefined
vac-serial.c:13:1: warning: this is the location of the previous definition

Don't define CONFIG_SERIAL_SHARE_IRQ if it's already defined by the
build system.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/vac-serial.c linux-2.4/drivers/char/vac-serial.c
--- linux-2.4-vanilla/drivers/char/vac-serial.c	Tue Nov 11 17:51:12 2003
+++ linux-2.4/drivers/char/vac-serial.c	Sat Jan 31 19:19:50 2004
@@ -10,7 +10,9 @@
 #define CONFIG_SERIAL_NOPAUSE_IO
 #define SERIAL_DO_RESTART
 
+#ifndef CONFIG_SERIAL_SHARE_IRQ
 #define CONFIG_SERIAL_SHARE_IRQ
+#endif
 
 /* Set of debugging defines */
 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Sei l'unica donna della mia vita".
(Adamo)
