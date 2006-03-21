Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWCUDfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWCUDfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 22:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWCUDfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 22:35:03 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:27590 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965014AbWCUDe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 22:34:59 -0500
Message-ID: <441F7462.4040707@linuxtv.org>
Date: Mon, 20 Mar 2006 22:34:58 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stable@kernel.org
CC: lkml <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: [2.6.16 STABLE PATCH] Kconfig: VIDEO_DECODER must select FW_LOADER
Content-Type: multipart/mixed;
 boundary="------------070904070804000608030500"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904070804000608030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch has been backported for 2.6.16.1 from the following patch,
which is queued for 2.6.17:

V4L/DVB (3495): Kconfig: select VIDEO_CX25840 to build cx25840 a/v 
decoder module
http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commitdiff;h=4f767be057d0173eae7ef116de32a3f4f12888a8



--------------070904070804000608030500
Content-Type: text/x-patch;
 name="cx25840_must_select_fw_loader.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cx25840_must_select_fw_loader.patch"

From: Michael Krufky <mkrufky@linuxtv.org>
Date: Mon, 20 Mar 2006 22:17:00 +0000 (-0500)
Subject: Kconfig: VIDEO_DECODER must select FW_LOADER

The cx25840 module requires external firmware in order to function,
so it must select FW_LOADER, but saa7115 and saa7129 do not require it.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
---

--- 
linux-2.6.16.orig/drivers/media/video/Kconfig
+++ linux-2.6.16/drivers/media/video/Kconfig
@@ -349,6 +349,7 @@
 config VIDEO_DECODER
 	tristate "Add support for additional video chipsets"
 	depends on VIDEO_DEV && I2C && EXPERIMENTAL
+	select FW_LOADER
 	---help---
 	  Say Y here to compile drivers for SAA7115, SAA7127 and CX25840
 	  video decoders.

--------------070904070804000608030500--
