Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285250AbRLMXBH>; Thu, 13 Dec 2001 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285251AbRLMXA5>; Thu, 13 Dec 2001 18:00:57 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:11923
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S285250AbRLMXAv>; Thu, 13 Dec 2001 18:00:51 -0500
Message-ID: <009c01c1842a$d281f670$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: [PATCH] ide-probe does not set removable flag for ide-floppy devices
Date: Thu, 13 Dec 2001 16:06:39 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch, relative to 2.4.17-pre8, but should apply to any recent version

diff -urN -X dontdiff linux/drivers/ide/ide-probe.c
linux-new/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c Wed Dec 12 11:01:24 2001
+++ linux-new/drivers/ide/ide-probe.c Sun Dec  9 11:41:15 2001
@@ -122,6 +122,7 @@
       printk("cdrom or floppy?, assuming ");
      if (drive->media != ide_cdrom) {
       printk ("FLOPPY");
+      drive->removable = 1;
       break;
      }
     }


