Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWCUDe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWCUDe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 22:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWCUDe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 22:34:56 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:26054 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932269AbWCUDez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 22:34:55 -0500
Message-ID: <441F745E.1080202@linuxtv.org>
Date: Mon, 20 Mar 2006 22:34:54 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stable@kernel.org
CC: lkml <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>
Subject: [2.6.16 STABLE PATCH] V4L/DVB (3324): Fix Samsung tuner frequency
 ranges
Content-Type: multipart/mixed;
 boundary="------------080609040007060809000801"
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
--------------080609040007060809000801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a critical patch that didn't get pulled in time for 2.6.16
Please apply this to 2.6.16.1


--------------080609040007060809000801
Content-Type: text/x-patch;
 name="Fix_Samsung_tuner_frequency_ranges.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Fix_Samsung_tuner_frequency_ranges.patch"

From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Mon, 6 Feb 2006 21:52:24 +0000 (+0200)
Subject: V4L/DVB (3324): Fix Samsung tuner frequency ranges
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commitdiff;h=df821f758c37dce41fbef0d20932909332619f04

V4L/DVB (3324): Fix Samsung tuner frequency ranges

Forgot to take the NTSC frequency offset into account.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
---

--- linux-2.6.16.orig/drivers/media/video/tuner-types.c
+++ linux-2.6.16/drivers/media/video/tuner-types.c
@@ -1087,8 +1087,8 @@
 /* ------------ TUNER_SAMSUNG_TCPN_2121P30A - Samsung NTSC ------------ */
 
 static struct tuner_range tuner_samsung_tcpn_2121p30a_ntsc_ranges[] = {
-	{ 16 * 175.75 /*MHz*/, 0x01, },
-	{ 16 * 410.25 /*MHz*/, 0x02, },
+	{ 16 * 130.00 /*MHz*/, 0x01, },
+	{ 16 * 364.50 /*MHz*/, 0x02, },
 	{ 16 * 999.99        , 0x08, },
 };
 

--------------080609040007060809000801--
