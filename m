Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263504AbSJGWHE>; Mon, 7 Oct 2002 18:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263505AbSJGWHE>; Mon, 7 Oct 2002 18:07:04 -0400
Received: from u195-95-41-235.adsl.pi.be ([195.95.41.235]:38661 "EHLO
	jebril.pi.be") by vger.kernel.org with ESMTP id <S263475AbSJGWHA>;
	Mon, 7 Oct 2002 18:07:00 -0400
Message-Id: <200210072211.g97MBGVj030921@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.41 missing #include in aha152x.c
Date: Tue, 08 Oct 2002 00:11:15 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aha152x.c in 2.5.41 needs this to compile:

diff -ru linux.orig/drivers/scsi/aha152x.c linux.mce/drivers/scsi/aha152x.c
--- linux.orig/drivers/scsi/aha152x.c   Tue Oct  8 00:08:45 2002
+++ linux.mce/drivers/scsi/aha152x.c    Tue Oct  8 00:06:13 2002
@@ -250,6 +250,7 @@
 
 #include "aha152x.h"
 #include <linux/stat.h>
+#include <linux/workqueue.h>
 
 #include <scsi/scsicam.h>
 

MCE
