Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTBGQ6q>; Fri, 7 Feb 2003 11:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbTBGQ6p>; Fri, 7 Feb 2003 11:58:45 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:42372 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266638AbTBGQ6o>; Fri, 7 Feb 2003 11:58:44 -0500
Date: Fri, 7 Feb 2003 12:17:45 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/char/ip2/i2lib.c
Message-ID: <Pine.LNX.4.44.0302071214440.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 320, and separates 1 test 
into 2 separate 2 tests. Please review for inclusion.

Regards,
Frank

--- linux/drivers/char/ip2/i2lib.c.old	2003-01-16 21:22:57.000000000 -0500
+++ linux/drivers/char/ip2/i2lib.c	2003-02-07 02:54:36.000000000 -0500
@@ -1251,7 +1251,7 @@
 
 	}
 	if ( old_flags & STOPFL_FLAG ) {
-		if ( 1 == i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) > 0 ) {
+		if ((1 == i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL)) && (i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) > 0 )) {
 			old_flags = 0;	// Success - clear flags
 		}
 

