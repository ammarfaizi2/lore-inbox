Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVA2L21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVA2L21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 06:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVA2L21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 06:28:27 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:43791 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262899AbVA2L1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 06:27:54 -0500
Date: Sat, 29 Jan 2005 12:28:10 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] I2C updates for 2.4.29 (2/3)
Message-Id: <20050129122810.6c1a4957.khali@linux-fr.org>
In-Reply-To: <20050129120235.5c7160e6.khali@linux-fr.org>
References: <20050129120235.5c7160e6.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While editing i2c-algo-bit.c and i2c-algo-pcf.c (see 1/3 of this patch
set), I noticed that both files include header files they do not need at
all (namely linux/ioport.h and asm/uaccess.h). The following patch
cleans this, additionally bringing the files in line with what we have
in i2c CVS (thus the blank lines changes).

--- linux-2.4.29/drivers/i2c/i2c-algo-bit.c.orig	2005-01-29 11:33:33.000000000 +0100
+++ linux-2.4.29/drivers/i2c/i2c-algo-bit.c	2005-01-29 11:35:39.000000000 +0100
@@ -28,14 +28,12 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
-#include <linux/ioport.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
+
 /* ----- global defines ----------------------------------------------- */
 #define DEB(x) if (i2c_debug>=1) x;
 #define DEB2(x) if (i2c_debug>=2) x;
--- linux-2.4.29/drivers/i2c/i2c-algo-pcf.c.orig	2005-01-29 11:33:40.000000000 +0100
+++ linux-2.4.29/drivers/i2c/i2c-algo-pcf.c	2005-01-29 11:35:45.000000000 +0100
@@ -32,15 +32,13 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
-#include <linux/ioport.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
 #include "i2c-pcf8584.h"
 
+
 /* ----- global defines ----------------------------------------------- */
 #define DEB(x) if (i2c_debug>=1) x
 #define DEB2(x) if (i2c_debug>=2) x


-- 
Jean Delvare
http://khali.linux-fr.org/
