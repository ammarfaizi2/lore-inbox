Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUHTVVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUHTVVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUHTVVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:21:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24006 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S268752AbUHTVVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:21:20 -0400
Date: Fri, 20 Aug 2004 23:21:12 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200408202121.i7KLLCO04775.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] minix fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.18 some minix-specific stuff was moved to the minix
subdirectory where it belonged. However, a typo crept in.
A few people have complained, but so far not sufficiently loudly.

The bug is of a type that automated tools might discover:
a value res is computed, but not used.

Andries

Signed-off-by: Andries Brouwer

diff -uprN -X /linux/dontdiff a/fs/minixdiff -uprN -X /linux/dontdiff a/fs/minix/itree_common.c b/fs/minix/itree_common.c
--- a/fs/minix/itree_common.c	2003-12-18 03:59:05.000000000 +0100
+++ b/fs/minix/itree_common.c	2004-08-20 23:02:26.000000000 +0200
@@ -358,5 +358,5 @@ static inline unsigned nblocks(loff_t si
 		res += blocks;
 		direct = 1;
 	}
-	return blocks;
+	return res;
 }
