Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUFPV6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUFPV6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266326AbUFPV6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:58:20 -0400
Received: from jupiter.loonybin.net ([208.248.0.98]:7437 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S266327AbUFPV5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:57:51 -0400
Date: Wed, 16 Jun 2004 16:57:37 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hid-tmff fix again
Message-ID: <20040616215737.GA8253@bliss>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Posting again.  Still not applied as of 2.6.7.  The hid-tmff driver is
useless without this.

-- 
Zinx Verituse                                    http://zinx.xmms.org/

--3MwIy2ne0vdjdPXF
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

--3MwIy2ne0vdjdPXF--
