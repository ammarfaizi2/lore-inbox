Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSJHTNm>; Tue, 8 Oct 2002 15:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJHTNe>; Tue, 8 Oct 2002 15:13:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26896 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261381AbSJHTHz>; Tue, 8 Oct 2002 15:07:55 -0400
Subject: PATCH: wd7000 lock error Willy noticed
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:04:59 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzfA-0004ur-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/wd7000.c linux.2.5.41-ac1/drivers/scsi/wd7000.c
--- linux.2.5.41/drivers/scsi/wd7000.c	2002-10-07 22:12:26.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/wd7000.c	2002-10-07 14:45:34.000000000 +0100
@@ -877,7 +877,6 @@
 	 */
 	if (freescbs < needed) {
 	    printk (KERN_ERR "wd7000: can't get enough free SCBs.\n");
-	    spin_unlock_irq(host->host_lock);
 	    return (NULL);
 	}
     }
