Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSBMWLA>; Wed, 13 Feb 2002 17:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSBMWKw>; Wed, 13 Feb 2002 17:10:52 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:25545 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S289009AbSBMWKl>; Wed, 13 Feb 2002 17:10:41 -0500
Message-Id: <200202132122.OAA03230@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 2.5.4, add 2 help texts to drivers/scsi/Config.help
Date: Wed, 13 Feb 2002 15:09:29 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers/scsi/Config.in file contains 4 options which do not have any 
help text in drivers/scsi/Config.help (or anywhere else).

The following patch provides help texts for CONFIG_SGIWD93_SCSI and
CONFIG_SCSI_QLOGIC_FC_FIRMWARE.  The two help texts were added to
drivers/scsi/Config.help in the order that they appear in Config.in.

Two other options, CONFIG_SCSI_DECSII and CONFIG_SCSI_G_NCR5380_MEM could
use help texts.  The second of these is a choice option.

Steven

--- linux-2.5.4/drivers/scsi/Config.help.orig   Wed Feb 13 14:40:47 2002
+++ linux-2.5.4/drivers/scsi/Config.help        Wed Feb 13 14:46:40 2002
@@ -172,6 +172,10 @@
   there should be no noticeable performance impact as long as you have
   logging turned off.

+CONFIG_SGIWD93_SCSI
+  If you have a Western Digital WD93 SCSI controller on
+  an SGI MIPS system, say Y.  Otherwise, say N.
+
 CONFIG_SCSI_DECNCR
   Say Y here to support the NCR53C94 SCSI controller chips on IOASIC
   based TURBOchannel DECstations and TURBOchannel PMAZ-A cards.
@@ -971,6 +975,11 @@
   The module will be called qlogicfc.o.  If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.

+CONFIG_SCSI_QLOGIC_FC_FIRMWARE
+  Say Y to include ISP2100 Fabric Initiator/Target Firmware, with
+  expanded LUN addressing and FcTape (FCP-2) support, in the
+  Qlogic QLA 1280 driver.
+
 CONFIG_SCSI_QLOGIC_1280
   Say Y if you have a QLogic ISP1x80/1x160 SCSI host adapter.
