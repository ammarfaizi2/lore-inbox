Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268684AbTGIXit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268773AbTGIXhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:37:11 -0400
Received: from palrel10.hp.com ([156.153.255.245]:30159 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S268758AbTGIXgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:36:55 -0400
Date: Wed, 9 Jul 2003 16:51:33 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] IrCOMM devfs
Message-ID: <20030709235133.GF12747@bougret.hpl.hp.com>
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

ir254_ircomm_devfs.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Martin Diehl>
	o [CRITICA] fix IrCOMM bogus device names with devfs


diff -u -p linux/net/irda/ircomm/ircomm_tty.d1.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d1.c	Wed Jul  9 11:53:51 2003
+++ linux/net/irda/ircomm/ircomm_tty.c	Wed Jul  9 11:54:24 2003
@@ -119,6 +119,7 @@ int __init ircomm_tty_init(void)
 
 	driver->driver_name     = "ircomm";
 	driver->name            = "ircomm";
+	driver->devfs_name      = "ircomm";
 	driver->major           = IRCOMM_TTY_MAJOR;
 	driver->minor_start     = IRCOMM_TTY_MINOR;
 	driver->type            = TTY_DRIVER_TYPE_SERIAL;
