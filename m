Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTDHAah (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTDGXLF (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:11:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55168
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263759AbTDGXDc (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:03:32 -0400
Date: Tue, 8 Apr 2003 01:22:08 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080022.h380M82Z009071@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix radio-cadet build
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/media/radio/radio-cadet.c linux-2.5.67-ac1/drivers/media/radio/radio-cadet.c
--- linux-2.5.67/drivers/media/radio/radio-cadet.c	2003-04-08 00:37:36.000000000 +0100
+++ linux-2.5.67-ac1/drivers/media/radio/radio-cadet.c	2003-04-04 18:34:37.000000000 +0100
@@ -516,7 +516,7 @@
 	{.id = ""}
 };
 
-MODULE_DEVICE_TABLE(pnp, id_table);
+MODULE_DEVICE_TABLE(pnp, cadet_pnp_devices);
 
 static int cadet_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
 {
