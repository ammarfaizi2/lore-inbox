Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbTFNNjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265674AbTFNNiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:38:15 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:52651 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265673AbTFNNho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:37:44 -0400
Date: Sat, 14 Jun 2003 15:51:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21 zlib changes #1 memlevel
Message-ID: <20030614135133.GH15099@wohnheim.fh-wedel.de>
References: <20030614134708.GD15099@wohnheim.fh-wedel.de> <20030614134811.GE15099@wohnheim.fh-wedel.de> <20030614134912.GF15099@wohnheim.fh-wedel.de> <20030614135026.GG15099@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030614135026.GG15099@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce MAX_MEM_LEVEL to 8.  This reduces zlib memory consumption by
128k (from ~400k to ~270k) at the theoretical cost of worse
compression.  No code currently in the kernel actually uses the better
compression, so the practical cost is zero.

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu

--- linux-2.4.20/include/linux/zconf.h~zlib_memlevel	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/include/linux/zconf.h	2003-06-10 17:01:16.000000000 +0200
@@ -35,7 +35,7 @@
 
 /* Maximum value for memLevel in deflateInit2 */
 #ifndef MAX_MEM_LEVEL
-#  define MAX_MEM_LEVEL 9
+#  define MAX_MEM_LEVEL 8
 #endif
 
 /* Maximum value for windowBits in deflateInit2 and inflateInit2.
