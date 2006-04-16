Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWDPRvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWDPRvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 13:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDPRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 13:51:54 -0400
Received: from mail14.bluewin.ch ([195.186.19.62]:50369 "EHLO
	mail14.bluewin.ch") by vger.kernel.org with ESMTP id S1750775AbWDPRvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 13:51:53 -0400
Date: Sun, 16 Apr 2006 13:46:50 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] hugetlbfs: add Kconfig help text
Message-ID: <20060416174650.GA26124@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel bugzilla #6248 (http://bugzilla.kernel.org/show_bug.cgi?id=6248),
Adrian Bunk <bunk@stusta.de> notes that CONFIG_HUGETLBFS is missing Kconfig
help text.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 fs/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

72dcc1ea8198fe2545e1674f6658edd5aa4e77a5
diff --git a/fs/Kconfig b/fs/Kconfig
index 2524629..f9b5842 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -842,6 +842,12 @@ config TMPFS
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
+	help
+	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
+	  ramfs. For architectures that support it, say Y here and read
+	  <file:Documentation/vm/hugetlbpage.txt> for details.
+
+	  If unsure, say N.
 
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
-- 
1.2.4
