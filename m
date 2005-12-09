Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVLIGCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVLIGCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 01:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVLIGCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 01:02:10 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:19930 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751272AbVLIGCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 01:02:09 -0500
Message-ID: <43991E34.60503@gmail.com>
Date: Fri, 09 Dec 2005 01:03:32 -0500
From: Michael Krufky <mkrufky@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stable@kernel.org
CC: lkml <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, mkrufky@gmail.com
Subject: [STABLE PATCH] V4L/DVB: Fix analog NTSC for Thomson DTT 761X hybrid
 tuner
Content-Type: multipart/mixed;
 boundary="------------090903030002040906060107"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903030002040906060107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The following bugfix is already in 2.6.15-git1.  Please queue this up 
for 2.6.14.4

Thank you,

Michael Krufky



--------------090903030002040906060107
Content-Type: text/x-patch;
 name="thomson-dtt761x-tda9887-fix-ntsc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thomson-dtt761x-tda9887-fix-ntsc.patch"

[PATCH] V4L/DVB: Fix analog NTSC for Thomson DTT 761X hybrid tuner

- Enable tda9887 on the following cx88 boards:
  pcHDTV 3000
  FusionHDTV3 Gold-T
- This ensures that analog NTSC video will function properly, without 
  this patch, the tuner may appear to be broken.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
---

 cx88-cards.c |    2 ++
 1 file changed, 2 insertions(+)

diff -upr linux-2.6.14.3/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.14.3/drivers/media/video/cx88/cx88-cards.c	2005-10-27 20:02:08.000000000 -0400
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-12-09 00:44:22.000000000 -0500
@@ -567,6 +567,7 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -711,6 +712,7 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,

--------------090903030002040906060107--
