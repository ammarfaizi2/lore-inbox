Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWFVKDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWFVKDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWFVKDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:03:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41231 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161031AbWFVKDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:03:19 -0400
Date: Thu, 22 Jun 2006 12:03:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Anssi Hannula <anssi.hannula@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: [-mm patch] #if 0 drivers/usb/input/hid-core.c:hid_find_field_by_usage()
Message-ID: <20060622100318.GY9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's the no longer used hid_find_field_by_usage().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/input/hid-core.c |    3 ++-
 drivers/usb/input/hid.h      |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm1-full/drivers/usb/input/hid.h.old	2006-06-22 01:20:25.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/usb/input/hid.h	2006-06-22 01:20:33.000000000 +0200
@@ -519,7 +519,6 @@
 int hid_set_field(struct hid_field *, unsigned, __s32);
 void hid_submit_report(struct hid_device *, struct hid_report *, unsigned char dir);
 void hid_init_reports(struct hid_device *hid);
-struct hid_field *hid_find_field_by_usage(struct hid_device *hid, __u32 wanted_usage, int type);
 int hid_wait_io(struct hid_device* hid);
 
 
--- linux-2.6.17-mm1-full/drivers/usb/input/hid-core.c.old	2006-06-22 01:20:41.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/usb/input/hid-core.c	2006-06-22 01:21:00.000000000 +0200
@@ -1108,7 +1108,7 @@
 /*
  * Find a report field with a specified HID usage.
  */
-
+#if 0
 struct hid_field *hid_find_field_by_usage(struct hid_device *hid, __u32 wanted_usage, int type)
 {
 	struct hid_report *report;
@@ -1120,6 +1120,7 @@
 				return report->field[i];
 	return NULL;
 }
+#endif  /*  0  */
 
 static int hid_submit_out(struct hid_device *hid)
 {

