Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbTADWrY>; Sat, 4 Jan 2003 17:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTADWrY>; Sat, 4 Jan 2003 17:47:24 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:59084 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S261644AbTADWrX>;
	Sat, 4 Jan 2003 17:47:23 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, bcollins@debian.org
Subject: [PATCH]: create function with right arguments for sbp2
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 05 Jan 2003 00:03:29 +0100
Message-ID: <m2r8bsa56m.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
        The prototypes for this two functions was changed, but not the
        definitions.  This fix is at least needed for compiling, I
        don't have the hardware and haven't tested it.
        Looking at the 2.4.21-pre2 changed, it looks good.

Later, Juan.

diff -urNp --exclude-from=/home/mitica/quintela/config/misc/dontdiff t2/drivers/ieee1394/sbp2.c t1/drivers/ieee1394/sbp2.c
--- t2/drivers/ieee1394/sbp2.c	2002-12-31 18:10:52.000000000 +0100
+++ t1/drivers/ieee1394/sbp2.c	2003-01-03 19:50:21.000000000 +0100
@@ -1511,7 +1511,7 @@ static void sbp2_remove_device(struct sb
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_write(struct hpsb_host *host, int nodeid, int destid, quadlet_t *data,
-                                     u64 addr, unsigned int length)
+                                     u64 addr, unsigned int length, u16 flags)
 {
 
         /*
@@ -1527,7 +1527,7 @@ static int sbp2_handle_physdma_write(str
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_read(struct hpsb_host *host, int nodeid, quadlet_t *data,
-                                    u64 addr, unsigned int length)
+                                    u64 addr, unsigned int length, u16 flags)
 {
 
         /*


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
