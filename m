Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUFNDer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUFNDer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 23:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUFNDer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 23:34:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261786AbUFNDep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 23:34:45 -0400
Date: Sun, 13 Jun 2004 20:34:40 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Patch for USB in 2.4 to update unusual_devs.h
Message-Id: <20040613203440.42228d3b@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A regular update from Alan Stern - Sony Handycam HC-85.
-- Pete

diff -urp -X dontdiff linux-2.4.27-pre5/drivers/usb/storage/unusual_devs.h linux-2.4.27-pre5-usb/drivers/usb/storage/unusual_devs.h
--- linux-2.4.27-pre5/drivers/usb/storage/unusual_devs.h	2004-06-11 17:42:13.000000000 -0700
+++ linux-2.4.27-pre5-usb/drivers/usb/storage/unusual_devs.h	2004-06-12 14:48:42.000000000 -0700
@@ -273,6 +273,13 @@ UNUSUAL_DEV(  0x054c, 0x002e, 0x0106, 0x
 		US_SC_SCSI, US_PR_DEVICE, NULL,
 		US_FL_SINGLE_LUN | US_FL_MODE_XLATE),
 
+/* Submitted by Rajesh Kumble Nayak <nayak@obs-nice.fr> */
+UNUSUAL_DEV(  0x054c, 0x002e, 0x0500, 0x0500, 
+		"Sony",
+		"Handycam HC-85",
+		US_SC_UFI, US_PR_DEVICE, NULL,
+		US_FL_SINGLE_LUN | US_FL_MODE_XLATE),
+
 UNUSUAL_DEV(  0x054c, 0x0032, 0x0000, 0x9999,
 		"Sony",
 		"Memorystick MSC-U01N",
