Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292599AbSCIKJl>; Sat, 9 Mar 2002 05:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292592AbSCIKJb>; Sat, 9 Mar 2002 05:09:31 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:63020 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S292601AbSCIKJU>; Sat, 9 Mar 2002 05:09:20 -0500
Message-ID: <3C81318C00184C5A@mail.libertysurf.net> (added by
	    postmaster@libertysurf.fr)
Content-Type: text/plain; charset=US-ASCII
From: William Stinson <wstinson@infonie.fr>
Reply-To: wstinson@infonie.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] small patch to fix compilation error in drivers/char/rocket.c
Date: Sat, 9 Mar 2002 11:09:33 +0000
X-Mailer: KMail [version 1.3.1]
Cc: ak@muc.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

this is a (trivial) patch for compilation error in the rocketport serial driver.

Patch for 2.5.6. Please  CC' my for any answers/comments.

I also put this patch at http://www.chez.com/wstinson/linux/kernel/patch-rocket

William Stinson (wstinson@infonie.fr)

--- linux-2.5.6/drivers/char/rocket.c	Sat Mar  9 01:06:58 2002
+++ linux-local/drivers/char/rocket.c	Sat Mar  9 01:09:20 2002
@@ -227,7 +227,7 @@
 	if (!info)
 		return 1;
 	if (info->magic != RPORT_MAGIC) {
-		printk(badmagic, MAJOR(device), MINOR(device), routine);
+		printk(badmagic, major(device), minor(device), routine);
 		return 1;
 	}
 #endif
@@ -896,7 +896,7 @@
 	CHANNEL_t	*cp;
 	unsigned long page;
 	
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= MAX_RP_PORTS))
 		return -ENODEV;
 	if (!tmp_buf) {









_______________________________________________
Kernel-janitor-discuss mailing list
Kernel-janitor-discuss@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/kernel-janitor-discuss


-------------------------------------------------------
