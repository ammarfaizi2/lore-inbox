Return-Path: <linux-kernel-owner+willy=40w.ods.org-S287689AbUKBGws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S287689AbUKBGws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 01:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S443413AbUKBGws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 01:52:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9619 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S287689AbUKBGwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 01:52:32 -0500
Date: Tue, 2 Nov 2004 07:52:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix missing includes for isdn diversion
Message-ID: <Pine.LNX.4.53.0411020749010.13921@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





# File:  isdn_divert.diff
# Class: missing prototype addition
#
# Adds #include <linux/interrupt.h> to resolve missing calls to cli(),
# sti() and restore_flags().



Signed-off by: Jan Engelhardt <jengelh@linux01.gwdg.de>


diff -dpru linux-2.6.4-52/drivers/isdn/divert/divert_init.c linux-2.6.4-HX/drivers/isdn/divert/divert_init.c
--- linux-2.6.4-52/drivers/isdn/divert/divert_init.c	2004-05-26 17:35:48.000000000 +0200
+++ linux-2.6.4-HX/drivers/isdn/divert/divert_init.c	2004-05-27 21:19:38.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/version.h>
 #include <linux/init.h>
 #include "isdn_divert.h"
+#include <linux/interrupt.h>

 MODULE_DESCRIPTION("ISDN4Linux: Call diversion support");
 MODULE_AUTHOR("Werner Cornelius");
diff -dpru linux-2.6.4-52/drivers/isdn/divert/divert_procfs.c linux-2.6.4-HX/drivers/isdn/divert/divert_procfs.c
--- linux-2.6.4-52/drivers/isdn/divert/divert_procfs.c	2004-05-26 17:35:48.000000000 +0200
+++ linux-2.6.4-HX/drivers/isdn/divert/divert_procfs.c	2004-05-27 21:20:46.000000000 +0200
@@ -21,6 +21,7 @@
 #endif
 #include <linux/isdnif.h>
 #include "isdn_divert.h"
+#include <linux/interrupt.h>

 /*********************************/
 /* Variables for interface queue */
diff -dpru linux-2.6.4-52/drivers/isdn/divert/isdn_divert.c linux-2.6.4-HX/drivers/isdn/divert/isdn_divert.c
--- linux-2.6.4-52/drivers/isdn/divert/isdn_divert.c	2004-05-26 17:35:48.000000000 +0200
+++ linux-2.6.4-HX/drivers/isdn/divert/isdn_divert.c	2004-05-27 21:19:08.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/version.h>
 #include <linux/proc_fs.h>
 #include "isdn_divert.h"
+#include <linux/interrupt.h>

 /**********************************/
 /* structure keeping calling info */

##eof



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
