Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279379AbRJWLVm>; Tue, 23 Oct 2001 07:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279377AbRJWLVc>; Tue, 23 Oct 2001 07:21:32 -0400
Received: from hermes.domdv.de ([193.102.202.1]:17668 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279374AbRJWLVT>;
	Tue, 23 Oct 2001 07:21:19 -0400
Message-ID: <XFMail.20011023132046.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.6-3.Linux:20011023130230:5243=_"
Date: Tue, 23 Oct 2001 13:20:46 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] UltraStor 14F/34F build problem (2.4.13pre6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.6-3.Linux:20011023130230:5243=_
Content-Type: text/plain; charset=us-ascii

drivers/scsi/u14-34f.c fails to build when built into the kernel due to missing
MODULE_LICENSE definition. Patch attached.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--_=XFMail.1.4.6-3.Linux:20011023130230:5243=_
Content-Disposition: attachment; filename="u14-34f.patch"
Content-Transfer-Encoding: 7bit
Content-Description: u14-34f.patch
Content-Type: text/plain; charset=us-ascii; name=u14-34f.patch; SizeOnDisk=492

--- linux/drivers/scsi/u14-34f.c	Tue Oct 23 12:57:34 2001
+++ linux-fixed/drivers/scsi/u14-34f.c	Tue Oct 23 12:55:02 2001
@@ -334,6 +334,7 @@
  *  the driver sets host->wish_block = TRUE for all ISA boards.
  */
 
+#include <linux/module.h>
 #include <linux/version.h>
 
 #ifndef LinuxVersionCode
@@ -343,7 +344,6 @@
 #define MAX_INT_PARAM 10
 
 #if defined(MODULE)
-#include <linux/module.h>
 
 MODULE_PARM(boot_options, "s");
 MODULE_PARM(io_port, "1-" __MODULE_STRING(MAX_INT_PARAM) "i");

--_=XFMail.1.4.6-3.Linux:20011023130230:5243=_--
End of MIME message
