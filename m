Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTAYD6j>; Fri, 24 Jan 2003 22:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTAYD6j>; Fri, 24 Jan 2003 22:58:39 -0500
Received: from air-2.osdl.org ([65.172.181.6]:9605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266120AbTAYD6h>;
	Fri, 24 Jan 2003 22:58:37 -0500
Date: Fri, 24 Jan 2003 20:02:19 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix #warning's
Message-ID: <Pine.LNX.4.33L2.0301241946050.11224-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This fixes a few #warning's that gcc 2.96 complains about having
unmatched single-quote marks.  (warnings on #warnings)

Please apply.

-- 
~Randy





--- ./drivers/scsi/pcmcia/aha152x_stub.c%FIXIT	Thu Jan 16 18:22:42 2003
+++ ./drivers/scsi/pcmcia/aha152x_stub.c	Fri Jan 24 09:49:35 2003
@@ -350,7 +350,7 @@

     DEBUG(0, "aha152x_release_cs(0x%p)\n", link);

-#warning This doesn't protect you.  You need some real fix for your races.
+#warning This does not protect you.  You need some real fix for your races.
 #if 0
     if (GET_USE_COUNT(driver_template.module) != 0) {
 	DEBUG(1, "aha152x_cs: release postponed, "
--- ./drivers/scsi/pcmcia/fdomain_stub.c%FIXIT	Thu Jan 16 18:22:18 2003
+++ ./drivers/scsi/pcmcia/fdomain_stub.c	Fri Jan 24 09:51:03 2003
@@ -313,7 +313,7 @@

     DEBUG(0, "fdomain_release(0x%p)\n", link);

-#warning This doesn't protect you.  You need some real fix for your races.
+#warning This does not protect you.  You need some real fix for your races.
 #if 0
     if (GET_USE_COUNT(&__this_module) != 0) {
 	DEBUG(1, "fdomain_cs: release postponed, "
--- ./drivers/scsi/pcmcia/qlogic_stub.c%FIXIT	Thu Jan 16 18:22:14 2003
+++ ./drivers/scsi/pcmcia/qlogic_stub.c	Fri Jan 24 09:51:44 2003
@@ -329,7 +329,7 @@

 	DEBUG(0, "qlogic_release(0x%p)\n", link);

-#warning This doesn't protect you.  You need some real fix for your races.
+#warning This does not protect you.  You need some real fix for your races.
 #if 0
 	if (GET_USE_COUNT(&__this_module) != 0) {
 		DEBUG(0, "qlogic_cs: release postponed, device still open\n");

