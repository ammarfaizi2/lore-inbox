Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTGGRMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTGGRMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:12:13 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:17619 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264178AbTGGRML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:12:11 -0400
From: werner-schmi@t-online.de (Werner Schmidt)
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.22-pre3 Compiler warning, Makefile insert
Date: Mon, 7 Jul 2003 19:27:36 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I2aC/hC5D3qZ+qT"
Message-Id: <200307071927.37061.werner-schmi@t-online.de>
X-Seen: false
X-ID: VaHPsiZ6oeZq7LtAe3vPhCxPeLjkJaS8aM6LdmRmpBRjARqXrP6OE9@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_I2aC/hC5D3qZ+qT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hallo,

Compiler warning:
hid-core.c:879: Warnung: implicit declaration of function `hiddev_report_event'

Makefile insert:
make clean, make mrproper - lib/crc32tahle.h wird nicht entfernt.

mfg: Werner Schmidt
--Boundary-00=_I2aC/hC5D3qZ+qT
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="patch-hiddev"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-hiddev"

diff -Naur linux-2.4.22-pre3/include/linux/hiddev.h linux-2.4.22-pre4/include/linux/hiddev.h
--- linux-2.4.22-pre3/include/linux/hiddev.h	2003-07-06 11:20:50.000000000 +0200
+++ linux-2.4.22-pre4/include/linux/hiddev.h	2003-07-06 12:25:13.000000000 +0200
@@ -204,6 +204,7 @@
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
 		      struct hid_usage *usage, __s32 value);
+void hiddev_report_event(struct hid_device *hid, struct hid_report *report);
 int __init hiddev_init(void);
 void __exit hiddev_exit(void);
 #else

--Boundary-00=_I2aC/hC5D3qZ+qT
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="patch Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch Makefile"

diff -Naur linux-2.4.22-pre3/Makefile linux-2.5.2-pre4/Makefile
--- linux-2.4.21-pre3/Makefile	2003-07-06 11:20:44.000000000 +0200
+++ linux-2.4.22-pre4/Makefile	2003-07-06 12:14:13.000000000 +0200
@@ -220,6 +221,7 @@
 	drivers/scsi/aic7xxx/aicasm/aicdb.h \
 	drivers/scsi/aic7xxx/aicasm/y.tab.h \
 	drivers/scsi/53c700_d.h \
+	lib/crc32table.h \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
 	submenu*
@@ -241,6 +243,7 @@
 	drivers/sound/pndspini.c \
 	drivers/atm/fore200e_*_fw.c drivers/atm/.fore200e_*.fw \
 	.version .config* config.in config.old \
+	lib/crc32table.h \
 	scripts/tkparse scripts/kconfig.tk scripts/kconfig.tmp \
 	scripts/lxdialog/*.o scripts/lxdialog/lxdialog \
 	.menuconfig.log \

--Boundary-00=_I2aC/hC5D3qZ+qT--

