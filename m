Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTFHNGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 09:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTFHNGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 09:06:07 -0400
Received: from [211.167.76.68] ([211.167.76.68]:15595 "HELO soulinfo")
	by vger.kernel.org with SMTP id S261775AbTFHNGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 09:06:06 -0400
Date: Sun, 8 Jun 2003 21:19:28 +0800
From: hugang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: fix oops in driver/serial/core.c
Message-Id: <20030608211928.3d425b56.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hell all:

Fix bug in 2.5.70.

--- linux-2.5.70/drivers/serial/core.c.old	Sun Jun  8 21:11:49 2003
+++ linux-2.5.70/drivers/serial/core.c	Sun Jun  8 21:12:06 2003
@@ -2189,11 +2189,11 @@
 void uart_unregister_driver(struct uart_driver *drv)
 {
 	struct tty_driver *p = drv->tty_driver;
-	drv->tty_driver = NULL;
 	tty_unregister_driver(p);
 	kfree(drv->state);
 	kfree(drv->tty_driver->termios);
 	kfree(drv->tty_driver);
+	drv->tty_driver = NULL;
 }
 
 struct tty_driver *uart_console_device(struct console *co, int *index)


-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
http://soulinfo.com/~hugang/HuGang.asc
ICQ#         : 205800361
Registered Linux User : 204016
