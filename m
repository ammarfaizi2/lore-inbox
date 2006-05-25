Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWEYISv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWEYISv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 04:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWEYISv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 04:18:51 -0400
Received: from mx2.mail.ru ([194.67.23.122]:16702 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S965080AbWEYISu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 04:18:50 -0400
Date: Thu, 25 May 2006 12:22:38 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH] ufs: Unmark CONFIG_UFS_FS_WRITE as BROKEN -mm tree
Message-ID: <20060525082238.GA7406@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To find new bugs, I suggest revert this patch:
http://lkml.org/lkml/2006/1/31/275
in -mm tree.
So anybody except me can test "write support" of UFS.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc4/fs/Kconfig
===================================================================
--- linux-2.6.17-rc4.orig/fs/Kconfig
+++ linux-2.6.17-rc4/fs/Kconfig
@@ -1320,7 +1320,7 @@ config UFS_FS
 
 config UFS_FS_WRITE
 	bool "UFS file system write support (DANGEROUS)"
-	depends on UFS_FS && EXPERIMENTAL && BROKEN
+	depends on UFS_FS && EXPERIMENTAL
 	help
 	  Say Y here if you want to try writing to UFS partitions. This is
 	  experimental, so you should back up your UFS partitions beforehand.

-- 
/Evgeniy

