Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261455AbSJHTOz>; Tue, 8 Oct 2002 15:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261465AbSJHTNp>; Tue, 8 Oct 2002 15:13:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27920 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261325AbSJHTIY>; Tue, 8 Oct 2002 15:08:24 -0400
Subject: PATCH: fix gcc 3.1/2 warnings in USB
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:05:33 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzfh-0004v6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/usb/serial/keyspan.c linux.2.5.41-ac1/drivers/usb/serial/keyspan.c
--- linux.2.5.41/drivers/usb/serial/keyspan.c	2002-10-07 22:12:26.000000000 +0100
+++ linux.2.5.41-ac1/drivers/usb/serial/keyspan.c	2002-10-07 23:03:42.000000000 +0100
@@ -530,7 +530,7 @@
 	if ((err = usb_submit_urb(urb, GFP_ATOMIC)) != 0) {
 		dbg("%s - resubmit read urb failed. (%d)", __FUNCTION__, err);
 	}
-exit:
+exit: ;
 }
 
 static void	usa26_glocont_callback(struct urb *urb)
@@ -665,7 +665,7 @@
 	if ((err = usb_submit_urb(urb, GFP_ATOMIC)) != 0) {
 		dbg("%s - resubmit read urb failed. (%d)", __FUNCTION__, err);
 	}
-exit:	
+exit: ;
 }
 
 static void	usa28_glocont_callback(struct urb *urb)
@@ -758,7 +758,7 @@
 	if ((err = usb_submit_urb(urb, GFP_ATOMIC)) != 0) {
 		dbg("%s - resubmit read urb failed. (%d)", __FUNCTION__, err);
 	}
-exit:	
+exit:	;
 }
 
 static void	usa49_inack_callback(struct urb *urb)
