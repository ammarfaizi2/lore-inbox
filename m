Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933900AbWKTDRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933900AbWKTDRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 22:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbWKTDRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 22:17:35 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:27874 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S933900AbWKTDRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 22:17:34 -0500
Message-ID: <45611E4B.8060002@linuxtv.org>
Date: Sun, 19 Nov 2006 22:17:31 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: stable@kernel.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: [2.6.18.y PATCH] V4L: Do not enable VIDEO_V4L2 unconditionally
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

From: Maciej W. Rozycki <macro@linux-mips.org>

V4L: Do not enable VIDEO_V4L2 unconditionally

The VIDEO_V4L2 config setting is enabled unconditionally, even for
configurations with no support for this subsystem whatsoever. The
following patch adds the necessary dependency.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index ed4aa4e..9f7e1fe 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -54,6 +54,7 @@ config VIDEO_V4L1_COMPAT
 
 config VIDEO_V4L2
 	bool
+	depends on VIDEO_DEV
 	default y
 
 source "drivers/media/video/Kconfig"

