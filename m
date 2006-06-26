Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWFZQLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWFZQLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWFZQLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:11:12 -0400
Received: from jenny.ondioline.org ([66.220.1.122]:30980 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1750738AbWFZQLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:11:11 -0400
From: Paul Collins <paul@briny.ondioline.org>
To: ericvh@gmail.com, rminnich@lanl.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: do not include linux/version.h
Mail-Followup-To: ericvh@gmail.com, rminnich@lanl.gov, lucho@ionkov.net,
	v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 02:10:29 +1000
Message-ID: <87bqsfoq2y.fsf@briny.internal.ondioline.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I noticed that part of v9fs was being rebuilt when version.h changed.

Here is a compile-tested patch against Linus's current tree.

Signed-off-by: Paul Collins <paul@ondioline.org>

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index efda46f..56f7060 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -31,7 +31,6 @@ #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
-#include <linux/version.h>
 #include <linux/pagemap.h>
 #include <linux/idr.h>
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 1a8e460..c3c47ed 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -31,7 +31,6 @@ #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
-#include <linux/version.h>
 #include <linux/list.h>
 #include <asm/uaccess.h>
 #include <linux/idr.h>

-- 
Paul Collins
Melbourne, Australia

Dag vijandelijk luchtschip de huismeester is dood
