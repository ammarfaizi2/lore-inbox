Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUAHCgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAHCfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:35:18 -0500
Received: from palrel12.hp.com ([156.153.255.237]:40373 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263539AbUAHCem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:34:42 -0500
Date: Wed, 7 Jan 2004 18:34:39 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrCOMM module alias
Message-ID: <20040108023438.GE13620@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_ircomm_alias.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [FEATURE] Add module alias for IrCOMM pseudo serial device.


diff -urp linux-2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c v2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c
--- linux-2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c	Wed Nov 19 12:33:50 2003
+++ v2.6.0-test9-bk22/net/irda/ircomm/ircomm_tty.c	Wed Nov 19 14:49:42 2003
@@ -38,6 +38,7 @@
 #include <linux/termios.h>
 #include <linux/tty.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>		/* for MODULE_ALIAS_CHARDEV_MAJOR */
 
 #include <asm/uaccess.h>
 
@@ -1408,6 +1409,7 @@ done:
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("IrCOMM serial TTY driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(IRCOMM_TTY_MAJOR);
 
 module_init(ircomm_tty_init);
 module_exit(ircomm_tty_cleanup);

