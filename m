Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTKJTfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTKJTeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:34:02 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:52752 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264094AbTKJTcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:32:51 -0500
Date: Mon, 10 Nov 2003 20:31:34 +0100
From: Jean Delvare <khali@linux-fr.org>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] pcmcia/sa1100_stork.c doesn't need i2c
Message-Id: <20031110203134.7cf624f7.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, hi all,

The pcmcia/sa1100_stork.c file has an include on i2c.h, while it doesn't seem to make any use of it. The simple patch below fixes that. Same applies to Linux 2.6, post follows.

--- linux-2.4.23-pre9/drivers/pcmcia/sa1100_stork.c.orig	Tue Jul 15 12:23:03 2003
+++ linux-2.4.23-pre9/drivers/pcmcia/sa1100_stork.c	Mon Nov 10 19:58:18 2003
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/i2c.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>

Please apply.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
