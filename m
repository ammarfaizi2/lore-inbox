Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWDDTKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWDDTKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWDDTKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:10:44 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:15563
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750816AbWDDTKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:10:43 -0400
Subject: [PATCH] tty release_dev remove dead code
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 14:10:35 -0500
Message-Id: <1144177835.3423.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead code from tty_io.c release_dev()

--- linux-2.6.16/drivers/char/tty_io.c	2006-04-04 13:58:57.000000000 -0500
+++ b/drivers/char/tty_io.c	2006-04-04 13:59:51.000000000 -0500
@@ -1733,7 +1733,7 @@ static void release_dev(struct file * fi
 {
 	struct tty_struct *tty, *o_tty;
 	int	pty_master, tty_closing, o_tty_closing, do_sleep;
-	int	devpts_master, devpts;
+	int	devpts;
 	int	idx;
 	char	buf[64];
 	unsigned long flags;
@@ -1750,7 +1750,6 @@ static void release_dev(struct file * fi
 	pty_master = (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 		      tty->driver->subtype == PTY_TYPE_MASTER);
 	devpts = (tty->driver->flags & TTY_DRIVER_DEVPTS_MEM) != 0;
-	devpts_master = pty_master && devpts;
 	o_tty = tty->link;
 
 #ifdef TTY_PARANOIA_CHECK


