Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319307AbSHVFtj>; Thu, 22 Aug 2002 01:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319308AbSHVFtj>; Thu, 22 Aug 2002 01:49:39 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:18610 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S319307AbSHVFti>;
	Thu, 22 Aug 2002 01:49:38 -0400
Date: Thu, 22 Aug 2002 07:56:23 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: martin@dalecki.de
Subject: [PATCH] export symbol (unregister_ata_driver)
Message-ID: <20020822055623.GA1536@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo l-k,

when I compiled 2.5.31 kernel, I have ide-scsi as modul, but while
depmod is running, I've got message:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.31; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.31/kernel/drivers/scsi/ide-scsi.o
depmod:         unregister_ata_driver

Then I sending patch for drivers/ide/main.c, which is need for export
this symbol...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="main.c.diff"

--- drivers/ide/main.c.old	2002-08-11 03:41:16.000000000 +0200
+++ drivers/ide/main.c	2002-08-22 07:41:03.000000000 +0200
@@ -1124,6 +1124,7 @@
 	}
 }
 
+EXPORT_SYMBOL(unregister_ata_driver);
 EXPORT_SYMBOL(ide_hwifs);
 EXPORT_SYMBOL(ide_lock);
 

--A6N2fC+uXW/VQSAv--
