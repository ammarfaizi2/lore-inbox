Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRF2WAu>; Fri, 29 Jun 2001 18:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbRF2WAl>; Fri, 29 Jun 2001 18:00:41 -0400
Received: from beppo.feral.com ([192.67.166.79]:61702 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S262634AbRF2WAe>;
	Fri, 29 Jun 2001 18:00:34 -0400
Date: Fri, 29 Jun 2001 15:00:17 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RESEND: [ PATCH ] externalize (new) scsi timer function
In-Reply-To: <Pine.LNX.4.21.0101111613210.29666-100000@zeppo.feral.com>
Message-ID: <20010629145838.X13977-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sent this back in January and previously. I still think they're important.
FWIW, Doug Gilbert thought they were okay.

-matt

--- linux.orig/drivers/scsi/scsi_syms.c Wed Nov 29 18:19:45 2000
+++ linux/drivers/scsi/scsi_syms.c Wed Nov 29 18:18:35 2000
@@ -91,3 +91,10 @@
 EXPORT_SYMBOL(scsi_devicelist);
 EXPORT_SYMBOL(scsi_device_types);

+/*
+ * Externalize timers so that HBAs can safely start/restart commands.
+ */
+extern void scsi_add_timer(Scsi_Cmnd *, int, void ((*) (Scsi_Cmnd *)));
+extern int scsi_delete_timer(Scsi_Cmnd *);
+EXPORT_SYMBOL(scsi_add_timer);
+EXPORT_SYMBOL(scsi_delete_timer);




