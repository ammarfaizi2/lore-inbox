Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbTA0V5e>; Mon, 27 Jan 2003 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbTA0V5e>; Mon, 27 Jan 2003 16:57:34 -0500
Received: from [212.156.4.130] ([212.156.4.130]:21998 "EHLO fep01.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S263276AbTA0V5e>;
	Mon, 27 Jan 2003 16:57:34 -0500
Date: Tue, 28 Jan 2003 00:06:55 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: linux-kernel@vger.kernel.org
Cc: jsimmons@infradead.org, andreashappe@gmx.net
Subject: [PATCH] 2.5.59: radeonfb, no visible cursor at the fb console
Message-ID: <20030127220655.GA7650@ttnet.net.tr>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	jsimmons@infradead.org, andreashappe@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch fixes the cursor problem at radeonfb.c, reported at
http://bugme.osdl.org/show_bug.cgi?id=292

--- linux-2.5.59-vanilla/drivers/video/radeonfb.c       Mon Jan 27 23:25:39 2003
+++ linux-2.5.59/drivers/video/radeonfb.c       Mon Jan 27 23:44:02 2003
@@ -2212,6 +2212,7 @@
        .fb_copyarea    = cfb_copyarea,
        .fb_imageblit   = cfb_imageblit,
 #endif
+       .fb_cursor      =  soft_cursor,
 };
