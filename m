Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278357AbRJSLLV>; Fri, 19 Oct 2001 07:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278359AbRJSLLM>; Fri, 19 Oct 2001 07:11:12 -0400
Received: from oriloff.manu.com.au ([203.37.120.101]:17929 "EHLO
	oriloff.manu.com.au") by vger.kernel.org with ESMTP
	id <S278357AbRJSLLG>; Fri, 19 Oct 2001 07:11:06 -0400
From: Nathan Hand <nathanh@manu.com.au>
Date: Fri, 19 Oct 2001 21:11:31 +1000
To: linux-kernel@vger.kernel.org
Cc: nathanh@manu.com.au
Subject: [PATCH] composite audio for bt878
Message-ID: <20011019211131.B9554@manu.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Composite audio for bttv card type 0x10 spews static although the
video is fine. Audio bitmask is wrong. One-line patch fixes it.


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bttv-cards.c.diff"

--- kernel-source-2.4.9/drivers/media/video/bttv-cards.c.orig	Fri Oct 19 20:56:43 2001
+++ kernel-source-2.4.9/drivers/media/video/bttv-cards.c	Fri Oct 19 20:56:48 2001
@@ -365,7 +365,7 @@
 	svhs:		2,
 	gpiomask:	0x01fe00,
 	muxsel:		{ 2, 3, 1, 1},
-	audiomux:	{ 0x01c000, 0, 0x018000, 0x014000, 0x002000, 0 },
+	audiomux:	{ 0x01c000, 0, 0x004000, 0x014000, 0x002000, 0 },
 	needs_tvaudio:	1,
 	pll:		PLL_28,
 	tuner_type:	-1,

--GID0FwUMdk1T2AWN--
