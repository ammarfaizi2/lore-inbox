Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVCLPH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVCLPH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVCLPH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:07:27 -0500
Received: from smtp.ono.com ([62.42.230.12]:58173 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S261933AbVCLPHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:07:20 -0500
Date: Sat, 12 Mar 2005 16:07:19 +0100
From: Guillermo Menguez Alvarez <gmenguez@usuarios.retecal.es>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]  Support for new ipod mini (and possibly others) + usb +
 linux 2.6
Message-ID: <20050312160719.0e07e453@casa.milicia.net>
X-Mailer: Sylpheed-Claws 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a little patch to unusual_devs.h in usb-storage in order to support
new ipods mini (ie. the new 6 gig model) and possibly other new big
models
reported to have problems through usb in linux 2.6.

Regards,
Guillermo.

--- linux-2.6.11/drivers/usb/storage/unusual_devs.h	2005-03-12 15:52:30.000000000 +0100
+++ linux-2.6.11-ipod/drivers/usb/storage/unusual_devs.h	2005-03-12 15:54:43.000000000 +0100
@@ -497,6 +497,12 @@ UNUSUAL_DEV( 0x05ac, 0x1203, 0x0001, 0x0
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_CAPACITY ),
 
+UNUSUAL_DEV( 0x05ac, 0x1205, 0x0001, 0x0001,
+		"Apple",
+		"iPod",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_FIX_CAPACITY ),
+
 #ifdef CONFIG_USB_STORAGE_JUMPSHOT
 UNUSUAL_DEV(  0x05dc, 0x0001, 0x0000, 0x0001,
 		"Lexar",


-- 
Usuario Linux #212057 - Maquinas Linux #98894, #130864 y #168988
Proyecto LONIX: http://lonix.sourceforge.net
Lagrimas en la Lluvia: http://www.lagrimasenlalluvia.com

