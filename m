Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291776AbSBNQkX>; Thu, 14 Feb 2002 11:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291780AbSBNQkO>; Thu, 14 Feb 2002 11:40:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:27920 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S291752AbSBNQkI>; Thu, 14 Feb 2002 11:40:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 14 Feb 2002 16:19:31 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] matroxfb fix
Message-ID: <20020214161931.B8112@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Trivial build fix for matroxfb (broken due to kdev_t changes).

  Gerd

---------------------------- cut here -------------------------
--- linux-2.5.5-pre1/drivers/video/matrox/matroxfb_base.c	Wed Nov 14 23:52:20 2001
+++ linux/drivers/video/matrox/matroxfb_base.c	Thu Feb 14 15:20:44 2002
@@ -1789,7 +1789,7 @@
 
 	strcpy(ACCESS_FBINFO(fbcon.modename), "MATROX VGA");
 	ACCESS_FBINFO(fbcon.changevar) = NULL;
-	ACCESS_FBINFO(fbcon.node) = -1;
+	ACCESS_FBINFO(fbcon.node) = NODEV;
 	ACCESS_FBINFO(fbcon.fbops) = &matroxfb_ops;
 	ACCESS_FBINFO(fbcon.disp) = d;
 	ACCESS_FBINFO(fbcon.switch_con) = &matroxfb_switch;
