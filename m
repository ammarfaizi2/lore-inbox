Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVAHVlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVAHVlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVAHVlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:41:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30212 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261661AbVAHVkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:40:14 -0500
Date: Sat, 8 Jan 2005 22:40:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] ide-scsi.c: make 2 functions static (fwd) (fwd)
Message-ID: <20050108214008.GT14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 2.6.10-mm2.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Tue, 21 Dec 2004 01:41:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] ide-scsi.c: make 2 functions static (fwd)

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 15 Nov 2004 03:07:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ide-scsi.c: make 2 functions static

The patch below makes two functions without external users static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ide-scsi.c.old	2004-11-13 21:51:26.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ide-scsi.c	2004-11-13 21:51:41.000000000 +0100
@@ -301,7 +301,7 @@
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
-ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
+static ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
 {
 	struct request *rq;
 	byte err;
@@ -327,7 +327,7 @@
 	return ide_stopped;
 }
 
-ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
+static ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
 {
 	struct request *rq;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

