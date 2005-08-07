Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVHGHwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVHGHwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 03:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVHGHwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 03:52:05 -0400
Received: from 83-65-247-144.dynamic.xdsl-line.inode.at ([83.65.247.144]:9210
	"EHLO mercury.foo") by vger.kernel.org with ESMTP id S1751218AbVHGHwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 03:52:05 -0400
Date: Sun, 7 Aug 2005 09:53:13 +0200 (CEST)
From: Dominik Hackl <dominik@hackl.dhs.org>
X-X-Sender: dominik@mercury.foo
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc5] crc32.c typing error fix
Message-ID: <Pine.LNX.4.61.0508070943070.6082@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes a typing error in lib/crc32.c which results in incorrect 
debug output.


        Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>



--- linux-2.6.13-rc5.orig/lib/crc32.c	2005-08-07 09:25:00.000000000 +0200
+++ linux-2.6.13-rc5/lib/crc32.c	2005-08-07 09:40:46.000000000 +0200
@@ -473,7 +473,7 @@ static u32 test_step(u32 init, unsigned 
 	init = bitreverse(init);
 	crc2 = bitreverse(crc1);
 	if (crc1 != bitreverse(crc2))
-		printf("\nBit reversal fail: 0x%08x -> %0x08x -> 0x%08x\n",
+		printf("\nBit reversal fail: 0x%08x -> 0x%08x -> 0x%08x\n",
 		       crc1, crc2, bitreverse(crc2));
 	crc1 = crc32_le(init, buf, len);
 	if (crc1 != crc2)
