Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTEODV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEODVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:21:45 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:29676 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263823AbTEODSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:32 -0400
Date: Thu, 15 May 2003 04:31:17 +0100
Message-Id: <200305150331.h4F3VHID000770@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, gregkh@kroah.com
Subject: mysterious shifts in USB storage drivers.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These went into 2.4 over a year ago. Unfortunatly,
with no comments in the logs.


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/datafab.c linux-2.5/drivers/usb/storage/datafab.c
--- bk-linus/drivers/usb/storage/datafab.c	2003-04-10 06:01:25.000000000 +0100
+++ linux-2.5/drivers/usb/storage/datafab.c	2003-03-17 23:42:38.000000000 +0000
@@ -670,7 +670,7 @@ int datafab_transport(Scsi_Cmnd * srb, s
 			srb->result = SUCCESS;
 		} else {
 			info->sense_key = UNIT_ATTENTION;
-			srb->result = CHECK_CONDITION << 1;
+			srb->result = CHECK_CONDITION;
 		}
 		return rc;
 	}
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/jumpshot.c linux-2.5/drivers/usb/storage/jumpshot.c
--- bk-linus/drivers/usb/storage/jumpshot.c	2003-04-10 06:01:25.000000000 +0100
+++ linux-2.5/drivers/usb/storage/jumpshot.c	2003-03-17 23:42:38.000000000 +0000
@@ -611,7 +611,7 @@ int jumpshot_transport(Scsi_Cmnd * srb, 
 			srb->result = SUCCESS;
 		} else {
 			info->sense_key = UNIT_ATTENTION;
-			srb->result = CHECK_CONDITION << 1;
+			srb->result = CHECK_CONDITION;
 		}
 		return rc;
 	}
