Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbUKMXnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUKMXnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUKMXlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:41:08 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:10400
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261211AbUKMXkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:40:24 -0500
Message-ID: <41969B65.9000807@ppp0.net>
Date: Sun, 14 Nov 2004 00:40:21 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] sr module_param conversion
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module_param conversion for SCSI cdrom driver

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>


diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	2004-11-14 00:36:56 +01:00
+++ b/drivers/scsi/sr.c	2004-11-14 00:36:56 +01:00
@@ -59,9 +59,6 @@
 #include "sr.h"


-MODULE_PARM(xa_test, "i");	/* see sr_ioctl.c */
-
-
 #define SR_DISKS	256

 #define MAX_RETRIES	3
diff -Nru a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
--- a/drivers/scsi/sr_ioctl.c	2004-11-14 00:36:56 +01:00
+++ b/drivers/scsi/sr_ioctl.c	2004-11-14 00:36:56 +01:00
@@ -29,6 +29,9 @@
  * It is off by default and can be turned on with this module parameter */
 static int xa_test = 0;

+module_param(xa_test, int, S_IRUGO | S_IWUSR);
+
+
 #define IOCTL_RETRIES 3

 /* ATAPI drives don't have a SCMD_PLAYAUDIO_TI command.  When these drives
