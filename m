Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbSJWAhW>; Tue, 22 Oct 2002 20:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbSJWAhV>; Tue, 22 Oct 2002 20:37:21 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:4025 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262357AbSJWAhU>; Tue, 22 Oct 2002 20:37:20 -0400
Date: Tue, 22 Oct 2002 20:35:50 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : drivers/scsi/NCR_D700.c
Message-ID: <Pine.LNX.4.44.0210222034240.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch removes an outdated macro STATIC.
Regards,
Frank

--- linux/drivers/scsi/NCR_D700.c.old	Sat Oct 19 12:05:41 2002
+++ linux/drivers/scsi/NCR_D700.c	Tue Oct 22 19:29:29 2002
@@ -123,12 +123,6 @@
 #error "NCR_D700 driver only compiles for MCA"
 #endif
 
-#ifdef NCR_D700_DEBUG
-#define STATIC
-#else
-#define STATIC static
-#endif
-
 char *NCR_D700;			/* command line from insmod */
 
 MODULE_AUTHOR("James Bottomley");
@@ -186,7 +180,7 @@
  * essentially connectecd to the MCA bus independently, it is easier
  * to set them up as two separate host adapters, rather than one
  * adapter with two channels */
-STATIC int __init
+static int __init
 D700_detect(Scsi_Host_Template *tpnt)
 {
 	int slot = 0;
@@ -310,7 +304,7 @@
 }
 
 
-STATIC int
+static int
 D700_release(struct Scsi_Host *host)
 {
 	struct D700_Host_Parameters *hostdata = 

