Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262294AbSI1RvH>; Sat, 28 Sep 2002 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbSI1RvG>; Sat, 28 Sep 2002 13:51:06 -0400
Received: from mx1.airmail.net ([209.196.77.98]:29444 "EHLO mx1.airmail.net")
	by vger.kernel.org with ESMTP id <S262294AbSI1RvG>;
	Sat, 28 Sep 2002 13:51:06 -0400
Date: Sat, 28 Sep 2002 12:56:25 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 designated initializer patch for fs/exportfs
Message-ID: <20020928175625.GC22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small patch for converting fs/exportfs/expfs.c to use
C99 designated initializers. The patch is against 2.5.39.

Art Haas


--- linux-2.5.39/fs/exportfs/expfs.c.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.39/fs/exportfs/expfs.c	2002-09-28 10:36:22.000000000 -0500
@@ -514,12 +514,12 @@
 }
 
 struct export_operations export_op_default = {
-	decode_fh:	export_decode_fh,
-	encode_fh:	export_encode_fh,
+	.decode_fh	= export_decode_fh,
+	.encode_fh	= export_encode_fh,
 
-	get_name:	get_name,
-	get_parent:	get_parent,
-	get_dentry:	get_object,
+	.get_name	= get_name,
+	.get_parent	= get_parent,
+	.get_dentry	= get_object,
 };
 
 EXPORT_SYMBOL(export_op_default);
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
