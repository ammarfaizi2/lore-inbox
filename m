Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVIESdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVIESdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVIEScz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:32:55 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:53347 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932386AbVIEScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:52 -0400
Message-Id: <20050905183248.559257000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:19 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 10/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-export-parport-get-port-for-ppscsi.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help external ppSCSI driver by exporting parport_get_port to match the
parport_put_port.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

diff -Nru a/drivers/parport/share.c b/drivers/parport/share.c
--- a/drivers/parport/share.c	2004-10-28 10:39:58 +03:00
+++ b/drivers/parport/share.c	2004-12-15 22:50:57 +02:00
@@ -1007,6 +1007,7 @@
 EXPORT_SYMBOL(parport_unregister_driver);
 EXPORT_SYMBOL(parport_register_device);
 EXPORT_SYMBOL(parport_unregister_device);
+EXPORT_SYMBOL(parport_get_port);
 EXPORT_SYMBOL(parport_put_port);
 EXPORT_SYMBOL(parport_find_number);
 EXPORT_SYMBOL(parport_find_base);

--
