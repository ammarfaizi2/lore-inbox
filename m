Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSBDBCd>; Sun, 3 Feb 2002 20:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSBDBCX>; Sun, 3 Feb 2002 20:02:23 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:34040 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S288050AbSBDBCE>;
	Sun, 3 Feb 2002 20:02:04 -0500
Date: Mon, 4 Feb 2002 06:01:07 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: vandrove@vc.cvut.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb_base.c - a little fix
Message-ID: <20020204060107.A18956@zzz.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, below is the little fix.  It's self-explanatory.  Matrox's fb
can't be compiled without it.  Petr, please, apply it.


--- drivers/video/matrox/matroxfb_base.c.orig	Mon Feb  4 05:11:15 2002
+++ drivers/video/matrox/matroxfb_base.c	Mon Feb  4 05:16:05 2002
@@ -1789,7 +1789,7 @@
 
 	strcpy(ACCESS_FBINFO(fbcon.modename), "MATROX VGA");
 	ACCESS_FBINFO(fbcon.changevar) = NULL;
-	ACCESS_FBINFO(fbcon.node) = -1;
+	ACCESS_FBINFO(fbcon.node.value) = -1;
 	ACCESS_FBINFO(fbcon.fbops) = &matroxfb_ops;
 	ACCESS_FBINFO(fbcon.disp) = d;
 	ACCESS_FBINFO(fbcon.switch_con) = &matroxfb_switch;
