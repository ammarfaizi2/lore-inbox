Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUAVEyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 23:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUAVEyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 23:54:45 -0500
Received: from dp.samba.org ([66.70.73.150]:65209 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264310AbUAVEyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 23:54:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: "[iso-8859-2] Pawe? Goleniowski" <pawelg@dabrowa.pl>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] rivafb & small 16 bit mode problem
Date: Thu, 22 Jan 2004 15:51:45 +1100
Message-Id: <20040122045458.5B2922C100@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ani,

	I assume this should be in 2.6's drivers/video/riva/fbdev.c as
well?

Rusty.

Date: Thu, 8 Jan 2004 22:45:56 +0100
From: "[iso-8859-2] Pawe? Goleniowski" <pawelg@dabrowa.pl>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com, trivial@rustcorp.com.au
Subject: [PATCH for 2.4.x] rivafb & small 16 bit mode problem

I have already send this once before Xmas but it probably got lost, so I'm
sending it again:

There is a problem with 16 bit mode with rivafb. Colors are sometimes broken
(specialy under Midnight Commander). This small patch fixes it. I've been
using it for last months and it works without any problems.

Pawel 'Goldi' Goleniowski


--Boundary-00=_U+c//wvZdA6GwMA
Content-Type: TEXT/X-DIFF; CHARSET=iso-8859-2; NAME="patch-rivafb.diff"
Content-ID: <Pine.LNX.4.58L.0401220001133.18059@logos.cnet>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="patch-rivafb.diff"

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

--Boundary-00=_U+c//wvZdA6GwMA--

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
