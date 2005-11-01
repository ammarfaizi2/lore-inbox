Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVKAIN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVKAIN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVKAINz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:55 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:345 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964973AbVKAINr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:13:47 -0500
Message-ID: <43672397.1030006@m1k.net>
Date: Tue, 01 Nov 2005 03:13:11 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 08/37] dvb: remove duplicate key definitions
Content-Type: multipart/mixed;
 boundary="------------090800070800060307090303"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090800070800060307090303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------090800070800060307090303
Content-Type: text/x-patch;
 name="2371.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2371.patch"

From: Thorsten Maerz <torte@netztorte.de>

The duplicate key definitions cause misinterpretations with
other keys, e.g. the "TELETEXT" key clashes with "CHANNEL_UP"
and thus can not be used with LIRC.
This patch removes these duplicates.

Signed-off-by: Thorsten Maerz <torte@netztorte.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/dvb-usb/a800.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/dvb-usb/a800.c
+++ linux-2.6.14-git3/drivers/media/dvb/dvb-usb/a800.c
@@ -43,11 +43,9 @@
 	{ 0x02, 0x13, KEY_RIGHT },       /* R / CH RTN */
 	{ 0x02, 0x17, KEY_PROG2 },       /* SNAP SHOT */
 	{ 0x02, 0x10, KEY_PROG3 },       /* 16-CH PREV */
-	{ 0x02, 0x03, KEY_CHANNELUP },   /* CH UP */
 	{ 0x02, 0x1e, KEY_VOLUMEDOWN },  /* VOL DOWN */
 	{ 0x02, 0x0c, KEY_ZOOM },        /* FULL SCREEN */
 	{ 0x02, 0x1f, KEY_VOLUMEUP },    /* VOL UP */
-	{ 0x02, 0x02, KEY_CHANNELDOWN }, /* CH DOWN */
 	{ 0x02, 0x14, KEY_MUTE },        /* MUTE */
 	{ 0x02, 0x08, KEY_AUDIO },       /* AUDIO */
 	{ 0x02, 0x19, KEY_RECORD },      /* RECORD */
@@ -57,8 +55,6 @@
 	{ 0x02, 0x1d, KEY_BACK },        /* << / RED */
 	{ 0x02, 0x1c, KEY_FORWARD },     /* >> / YELLOW */
 	{ 0x02, 0x03, KEY_TEXT },        /* TELETEXT */
-	{ 0x02, 0x01, KEY_FIRST },       /* |<< / GREEN */
-	{ 0x02, 0x00, KEY_LAST },        /* >>| / BLUE */
 	{ 0x02, 0x04, KEY_EPG },         /* EPG */
 	{ 0x02, 0x15, KEY_MENU },        /* MENU */
 



--------------090800070800060307090303--
