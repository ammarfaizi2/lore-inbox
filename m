Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUD2T1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUD2T1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUD2T1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:27:06 -0400
Received: from jupiter.loonybin.net ([208.248.0.98]:5650 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S264929AbUD2T1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:27:02 -0400
Date: Thu, 29 Apr 2004 14:26:56 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial fix for hid-tmff driver
Message-ID: <20040429192656.GA13053@bliss>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Well, this has been a problem for quite some time due to a change in
the list code way back when, and my mails don't seem to be getting
through to Vojtech Pavlik, so here's the patch..  The problem may still
exist in the other drivers..

-- 
Zinx Verituse                                    http://zinx.xmms.org/

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.5-hid-tmff.diff"

diff -ru linux-2.6.5.orig/drivers/usb/input/hid-tmff.c linux-2.6.5/drivers/usb/input/hid-tmff.c
--- linux-2.6.5.orig/drivers/usb/input/hid-tmff.c	2003-10-25 13:43:59.000000000 -0500
+++ linux-2.6.5/drivers/usb/input/hid-tmff.c	2003-12-18 01:00:41.000000000 -0600
@@ -110,7 +110,7 @@
 {
 	struct tmff_device *private;
 	struct list_head *pos;
-	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 
 	private = kmalloc(sizeof(struct tmff_device), GFP_KERNEL);
 	if (!private)

--OXfL5xGRrasGEqWY--
