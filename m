Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131684AbQJ2NcW>; Sun, 29 Oct 2000 08:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbQJ2NcN>; Sun, 29 Oct 2000 08:32:13 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:20490 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S131684AbQJ2Nb5>; Sun, 29 Oct 2000 08:31:57 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Linux 2.2.18pre18
Date: 29 Oct 2000 13:32:04 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8th8sk$9rs$1@enterprise.cistron.net>
In-Reply-To: <E13peHk-0005ep-00@the-village.bc.nu>
X-Trace: enterprise.cistron.net 972826324 10108 195.64.65.201 (29 Oct 2000 13:32:04 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E13peHk-0005ep-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>2.2.18pre18
>o	Fix rtc_lock for ide-probe, and hd.c		(Richard Johnson)

I need this to get it to compile:

--- linux-2.2.18pre18.orig/drivers/block/ide-probe.c	Sun Oct 29 13:02:39 2000
+++ linux-2.2.18pre18/drivers/block/ide-probe.c	Sun Oct 29 14:26:20 2000
@@ -45,6 +45,8 @@
 
 #include "ide.h"
 
+extern spinlock_t rtc_lock;
+
 static inline void do_identify (ide_drive_t *drive, byte cmd)
 {
 	int bswap = 1;


Mike.
-- 
People get the operating system they deserve.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
