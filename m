Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUFFBdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUFFBdi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 21:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUFFBdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 21:33:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:63621 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261479AbUFFBdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 21:33:36 -0400
Date: Sun, 6 Jun 2004 03:31:30 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable UDF debugging
Message-Id: <20040606033130.78cbdf18.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


UDF spews out lots of debugging information by default. Disable that, since
it doesn't make too much sense for a production kernel.

diff -u linux/include/linux/udf_fs.h-o linux/include/linux/udf_fs.h
--- linux/include/linux/udf_fs.h-o	2004-04-06 13:12:23.000000000 +0200
+++ linux/include/linux/udf_fs.h	2004-06-06 03:19:51.000000000 +0200
@@ -40,7 +40,7 @@
 #define UDFFS_DATE			"2004/29/09"
 #define UDFFS_VERSION			"0.9.8.1"
 
-#define UDFFS_DEBUG
+#undef UDFFS_DEBUG
 
 #ifdef UDFFS_DEBUG
 #define udf_debug(f, a...) \
