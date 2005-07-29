Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVG2TUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVG2TUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVG2TTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:39087 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262762AbVG2TRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:49 -0400
Date: Fri, 29 Jul 2005 12:17:25 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, omote@utyuuzin.net
Subject: [patch 24/29] USB: Patch for KYOCERA AH-K3001V support
Message-ID: <20050729191725.GZ5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-cdc_acp-kyocera-device-add.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahito Omote <omote@utyuuzin.net>

This patch enables a support of KYOCERA AH-K3001V, one of the most
popular cell phone in Japan. This device has vendor specific ID but works
with acm driver by adding USB ID. This device already works on
FreeBSD and OS X by native USB ACM driver with USB ID added.

This device is probed as NO_UNION_NORMAL not to hang up when probing.

Signed-off-by: Masahito Omote <omote@utyuuzin.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 files changed, 3 insertions(+)

--- gregkh-2.6.orig/drivers/usb/class/cdc-acm.c	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/class/cdc-acm.c	2005-07-29 11:36:31.000000000 -0700
@@ -980,6 +980,9 @@
 	{ USB_DEVICE(0x0870, 0x0001), /* Metricom GS Modem */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
+	{ USB_DEVICE(0x0482, 0x0203), /* KYOCERA AH-K3001V */
+	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
+	},
 	/* control interfaces with various AT-command sets */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_ACM_PROTO_AT_V25TER) },

--
