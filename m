Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265018AbSJVU0e>; Tue, 22 Oct 2002 16:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbSJVUZY>; Tue, 22 Oct 2002 16:25:24 -0400
Received: from dyn-212-232-43-250.ppp.tiscali.fr ([212.232.43.250]:65292 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S264999AbSJVUYR>; Tue, 22 Oct 2002 16:24:17 -0400
Message-ID: <3DB5B585.2060105@paulbristow.net>
Date: Tue, 22 Oct 2002 22:31:01 +0200
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Mark ide-floppy drives as removeable in ide-probe.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch marks ide-floppy drives as removeable.  devfs and 
partition handling code needs this to work properly.  Please apply.

-- 

Paul

Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223



--- linux-2.5.44/drivers/ide/ide-probe.c.orig    Tue Oct 22 23:26:31 2002
+++ linux-2.5.44/drivers/ide/ide-probe.c    Tue Oct 22 23:22:27 2002
@@ -166,6 +166,7 @@
                         printk("cdrom or floppy?, assuming ");
                     if (drive->media != ide_cdrom) {
                         printk ("FLOPPY");
+                        drive->removable = 1;
                         break;
                     }
                 }


