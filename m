Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVAHGci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVAHGci (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVAHGbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:31:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:16006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261929AbVAHFsr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:47 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632662253@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:47 -0800
Message-Id: <11051632671247@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.28, 2004/12/16 14:39:21-08:00, phil@ipom.com

[PATCH] USB Storage: unusual_devs: prolific atapi controler

This adds an unusual devices entry for a Prolific ATAPI-6 conmtroller
that needs the FIX_CAPACITY flag.


Signed-off-by: Alex Butcher <alex.butcher@assursys.co.uk>
Signed-off-by: Phil Dibowitz <phil@ipom.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/storage/unusual_devs.h |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	2005-01-07 15:47:15 -08:00
+++ b/drivers/usb/storage/unusual_devs.h	2005-01-07 15:47:15 -08:00
@@ -532,6 +532,13 @@
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_CAPACITY ),
 
+/* Reported by Alex Butcher <alex.butcher@assursys.co.uk> */
+UNUSUAL_DEV( 0x067b, 0x3507, 0x0001, 0x0001,
+		"Prolific Technology Inc.",
+		"ATAPI-6 Bridge Controller",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_FIX_CAPACITY ),
+
 /* Submitted by Benny Sjostrand <benny@hostmobility.com> */
 UNUSUAL_DEV( 0x0686, 0x4011, 0x0001, 0x0001,
 		"Minolta",

