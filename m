Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWCYRDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWCYRDk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCYRDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:03:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16399 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751112AbWCYRDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:03:39 -0500
Date: Sat, 25 Mar 2006 18:03:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/input/: proper prototypes
Message-ID: <20060325170338.GF4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds proper prototypes in a header file for some global 
functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/input/hid-ff.c |    6 ------
 drivers/usb/input/hid.h    |    5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

--- linux-2.6.16-mm1-full/drivers/usb/input/hid.h.old	2006-03-25 15:42:13.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/usb/input/hid.h	2006-03-25 15:43:38.000000000 +0100
@@ -533,3 +533,8 @@
 		return hid->ff_event(hid, input, type, code, value);
 	return -ENOSYS;
 }
+
+int hid_lgff_init(struct hid_device* hid);
+int hid_tmff_init(struct hid_device* hid);
+int hid_pid_init(struct hid_device* hid);
+
--- linux-2.6.16-mm1-full/drivers/usb/input/hid-ff.c.old	2006-03-25 15:43:47.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/usb/input/hid-ff.c	2006-03-25 15:44:09.000000000 +0100
@@ -34,12 +34,6 @@
 
 #include "hid.h"
 
-/* Drivers' initializing functions */
-extern int hid_lgff_init(struct hid_device* hid);
-extern int hid_lg3d_init(struct hid_device* hid);
-extern int hid_pid_init(struct hid_device* hid);
-extern int hid_tmff_init(struct hid_device* hid);
-
 /*
  * This table contains pointers to initializers. To add support for new
  * devices, you need to add the USB vendor and product ids here.

