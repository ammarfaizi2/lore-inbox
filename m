Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRLNXiy>; Fri, 14 Dec 2001 18:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbRLNXin>; Fri, 14 Dec 2001 18:38:43 -0500
Received: from www.transvirtual.com ([206.14.214.140]:22789 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S280686AbRLNXie>; Fri, 14 Dec 2001 18:38:34 -0500
Date: Fri, 14 Dec 2001 15:38:25 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH} IDE modular patch
Message-ID: <Pine.LNX.4.10.10112141537030.27606-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi! 

  On my system I select IDE to be completely modular. For 2.5.0-pre11 this
is broken. The following patch fixes this. 

  .-.                               .-.
  oo|  Give Microsoft The Bird!!!!  oo|
 /`'\  Use Linux!!!                /`'\
(_;/)                            (_;/)
-----------------------------------------------------

diff -urN -X /home/jsimmons/dontdiff linux-2.5.0/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.0/drivers/ide/ide.c	Thu Dec 13 11:31:47 2001
+++ linux/drivers/ide/ide.c	Fri Dec 14 16:32:50 2001
@@ -3686,6 +3686,7 @@
  */
 devfs_handle_t ide_devfs_handle;
 
+EXPORT_SYMBOL(ide_lock);
 EXPORT_SYMBOL(ide_probe);
 EXPORT_SYMBOL(drive_is_flashcard);
 EXPORT_SYMBOL(ide_timer_expiry);
@@ -3718,6 +3719,7 @@
 EXPORT_SYMBOL(ide_end_drive_cmd);
 EXPORT_SYMBOL(ide_end_request);
 EXPORT_SYMBOL(__ide_end_request);
+EXPORT_SYMBOL(ide_revalidate_drive);
 EXPORT_SYMBOL(ide_revalidate_disk);
 EXPORT_SYMBOL(ide_cmd);
 EXPORT_SYMBOL(ide_wait_cmd);

