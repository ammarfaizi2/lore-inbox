Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTLVWVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTLVWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:21:51 -0500
Received: from ofmail.of.pl ([217.97.243.238]:41625 "EHLO ofmail.of.pl")
	by vger.kernel.org with ESMTP id S264522AbTLVWVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:21:48 -0500
From: =?iso-8859-2?q?Pawe=B3=20Goleniowski?= <pawelg@dabrowa.pl>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.4] rivafb & 16 bit
Date: Mon, 22 Dec 2003 23:21:52 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A625/uxvEBaZ9x6"
Message-Id: <200312222321.52434.pawelg@dabrowa.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_A625/uxvEBaZ9x6
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There is a problem with 16 bit mode with rivafb. Colors are sometimes broken 
(specialy under Midnight Commander). This small patch fixes it. I've been 
using it for last months and it works without any problems.

Pawel 'Goldi' Goleniowski

--Boundary-00=_A625/uxvEBaZ9x6
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="patch-rivafb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-rivafb.diff"

--- linux/drivers/video/riva/accel.c	2003-12-22 22:46:27.000000000 +0100
+++ linux/drivers/video/riva/accel.c	2003-12-22 19:47:19.000000000 +0100
@@ -300,8 +300,8 @@
 
 static inline void convert_bgcolor_16(u32 *col)
 {
-	*col = ((*col & 0x00007C00) << 9)
-             | ((*col & 0x000003E0) << 6)
+	*col = ((*col & 0x0000F800) << 8)
+             | ((*col & 0x000007E0) << 5)
              | ((*col & 0x0000001F) << 3)
              |          0xFF000000;
 }

--Boundary-00=_A625/uxvEBaZ9x6--

