Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288759AbSATWqv>; Sun, 20 Jan 2002 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288781AbSATWql>; Sun, 20 Jan 2002 17:46:41 -0500
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:21255 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S288759AbSATWqY>;
	Sun, 20 Jan 2002 17:46:24 -0500
Date: Sun, 20 Jan 2002 17:34:37 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.3-pre2 : drivers/isdn/isdn_common.c
Message-ID: <Pine.LNX.4.33.0201201732120.906-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  Per Dave Jones' comment, I've attached the patch.

Regards,
Frank

--- drivers/isdn/isdn_common.c.old	Sun Jan 20 11:22:55 2002
+++ drivers/isdn/isdn_common.c	Sun Jan 20 17:29:59 2002
@@ -2253,7 +2253,7 @@
 	sprintf (buf, "isdn%d", k);
 	dev->devfs_handle_isdnX[k] =
 	    devfs_register (devfs_handle, buf, DEVFS_FL_DEFAULT,
-			    ISDN_MAJOR, ISDN_MINOR_B + k,0600 | S_IFCHR,
+			    ISDN_MAJOR, k,0600 | S_IFCHR,
 			    &isdn_fops, NULL);
 	sprintf (buf, "isdnctrl%d", k);
 	dev->devfs_handle_isdnctrlX[k] =

