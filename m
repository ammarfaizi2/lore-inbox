Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTJMOGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTJMOGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:06:50 -0400
Received: from imladris.surriel.com ([66.92.77.98]:16566 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261755AbTJMOGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:06:48 -0400
Date: Mon, 13 Oct 2003 10:06:42 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] clean up DAC960 case statement
Message-ID: <Pine.LNX.4.55L.0310130947380.30266@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is a lot happier if the case statement has a default.

diff -urNp linux-5110/drivers/block/DAC960.c linux-10010/drivers/block/DAC960.c
--- linux-5110/drivers/block/DAC960.c
+++ linux-10010/drivers/block/DAC960.c
@@ -5491,11 +5491,7 @@ static int DAC960_IOCTL(Inode_T *Inode,
 				       .part[MINOR(Inode->i_rdev)]
 				       .nr_sects << 9,
 		      (u64 *) Argument);
-    case BLKRAGET:
-    case BLKRASET:
-    case BLKFLSBUF:
-    case BLKBSZGET:
-    case BLKBSZSET:
+    default:
       return blk_ioctl(Inode->i_rdev, Request, Argument);
     case BLKRRPART:
       /* Re-Read Partition Table. */
