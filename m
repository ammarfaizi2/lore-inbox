Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUCEMZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUCEMZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:25:51 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:59908 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S262569AbUCEMZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:25:47 -0500
Date: Fri, 5 Mar 2004 13:25:44 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] missing <linux/mm.h> include in drivers/sbus/char/vfc_dev.c
Message-ID: <20040305122544.GF29693@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

drivers/sbus/char/vfc_dev (SUN_VIDEOPIX option) build stopped on:

drivers/sbus/char/vfc_dev.c: In function `vfc_mmap':
drivers/sbus/char/vfc_dev.c:623: error: dereferencing pointer to incomplete type
drivers/sbus/char/vfc_dev.c:623: error: dereferencing pointer to incomplete type
drivers/sbus/char/vfc_dev.c:627: error: dereferencing pointer to incomplete type
drivers/sbus/char/vfc_dev.c:628: error: `VM_SHM' undeclared (first use in this function)
[...and so on]

Fix attached.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-vfc_dev-include.patch"

--- linux-2.6.4-rc2/drivers/sbus/char/vfc_dev.c.orig	2004-03-04 06:16:48.000000000 +0000
+++ linux-2.6.4-rc2/drivers/sbus/char/vfc_dev.c	2004-03-05 12:00:34.000000000 +0000
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/mm.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>

--y0ulUmNC+osPPQO6--
