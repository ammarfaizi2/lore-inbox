Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbTCaQPE>; Mon, 31 Mar 2003 11:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbTCaQPE>; Mon, 31 Mar 2003 11:15:04 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:28544 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261702AbTCaQPD>; Mon, 31 Mar 2003 11:15:03 -0500
Date: Tue, 1 Apr 2003 01:24:59 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66-ac1] Update PC-9800 support (3/3) floppy driver
Message-ID: <20030331162459.GB1148@yuzuki.cinet.co.jp>
References: <20030331161604.GA1124@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331161604.GA1124@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the update patch for NEC PC-9800 subarchitecture
against 2.5.66-ac1. (3/3)
Please apply.

Update floppy driver for PC-98 to syncronize with floppy.c in 2.5.66.

diff -Nru linux-2.5.66-ac1/drivers/block/floppy98.c linux98-2.5.66-ac1/drivers/block/floppy98.c
--- linux-2.5.66-ac1/drivers/block/floppy98.c	2003-03-28 08:40:11.000000000 +0900
+++ linux98-2.5.66-ac1/drivers/block/floppy98.c	2003-03-25 09:13:24.000000000 +0900
@@ -3727,6 +3727,8 @@
 				name = default_drive_params[type].name;
 				allowed_drive_mask |= 1 << drive;
 			}
+			else
+				allowed_drive_mask &= ~(1 << drive);
 		} else {
 			params = &default_drive_params[0].params;
 			sprintf(temparea, "unknown type %d (usb?)", type);

Regards,
Osamu Tomita

