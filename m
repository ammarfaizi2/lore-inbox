Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbTIKGku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbTIKGkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:40:49 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:26855 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266161AbTIKGko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:40:44 -0400
Date: Thu, 11 Sep 2003 08:40:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
cc: linux-scsi@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] NCR5380.c warning
Message-ID: <Pine.GSO.4.21.0309110838240.1879-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NCR5380: `phases' is used inside the #ifdef NDEBUG only, so move its definition
inside as well.

--- linux-2.6.0-test5/drivers/scsi/NCR5380.c.orig	Tue Sep  9 10:13:04 2003
+++ linux-2.6.0-test5/drivers/scsi/NCR5380.c	Tue Sep  9 15:02:38 2003
@@ -390,6 +390,7 @@
 	return -ETIMEDOUT;
 }
 
+#ifdef NDEBUG
 static struct {
 	unsigned char value;
 	const char *name;
@@ -403,7 +404,6 @@
 	{PHASE_UNKNOWN, "UNKNOWN"}
 };
 
-#ifdef NDEBUG
 static struct {
 	unsigned char mask;
 	const char *name;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

