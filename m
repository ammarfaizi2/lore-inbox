Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTFFNsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 09:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTFFNsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 09:48:30 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:9095 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261561AbTFFNs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 09:48:26 -0400
Date: Fri, 6 Jun 2003 16:01:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib reduce deflate workspace by 128k
Message-ID: <20030606140149.GA20168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Free lunch time.  There are currently no users in the kernel that use
a memlevel >8, but we reserve space for 9.  The patch saves 128k at no
cost.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown

--- linux-2.5.70-bk11/include/linux/zconf.h~zlib_memlevel	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/include/linux/zconf.h	2003-06-06 15:57:28.000000000 +0200
@@ -23,7 +23,7 @@
 
 /* Maximum value for memLevel in deflateInit2 */
 #ifndef MAX_MEM_LEVEL
-#  define MAX_MEM_LEVEL 9
+#  define MAX_MEM_LEVEL 8
 #endif
 
 /* Maximum value for windowBits in deflateInit2 and inflateInit2.
