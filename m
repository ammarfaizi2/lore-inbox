Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFTMcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFTMcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 08:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVFTMcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 08:32:33 -0400
Received: from CPE00095b3131a0-CM0011ae8cd564.cpe.net.cable.rogers.com ([70.28.191.58]:51329
	"EHLO kenichi") by vger.kernel.org with ESMTP id S261235AbVFTMc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 08:32:29 -0400
From: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix Reiser4 Dependencies
Date: Mon, 20 Jun 2005 08:32:21 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
References: <20050619233029.45dd66b8.akpm@osdl.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506200832.22260.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*    ZLIB_INFLATE is not visible in menuconfig. Reiser4 should probably
     just select it like the other filesystems do.

*    Reiser4 also depends on ZLIB_DEFLATE.

signed-off-by: Andrew Wade <ajwade@alumni.uwaterloo.ca>

--- 2.6.12-mm1/fs/reiser4/Kconfig	2005-06-20 07:38:22.087653000 -0400
+++ linux/fs/reiser4/Kconfig	2005-06-20 08:01:28.914324250 -0400
@@ -1,6 +1,8 @@
 config REISER4_FS
 	tristate "Reiser4 (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && !4KSTACKS && ZLIB_INFLATE
+	depends on EXPERIMENTAL && !4KSTACKS
+	select ZLIB_INFLATE
+	select ZLIB_DEFLATE
 	help
 	  Reiser4 is a filesystem that performs all filesystem operations
 	  as atomic transactions, which means that it either performs a
