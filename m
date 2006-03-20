Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWCTWBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWCTWBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWCTWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:47289 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965001AbWCTWBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:04 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 22/23] sysfs: don't export dir symbols
In-Reply-To: <11428920391241-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:39 -0800
Message-Id: <11428920391737-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These functions should only be used by the kobject core, and if any
driver tries to use them, bad things happen.  Unexport them to try to
prevent this from happening.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 fs/sysfs/dir.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

832c57e9afa7a263bb2f8ee6d04d527ef6709aae
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index bea1f4c..9ee9568 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -510,7 +510,3 @@ struct file_operations sysfs_dir_operati
 	.read		= generic_read_dir,
 	.readdir	= sysfs_readdir,
 };
-
-EXPORT_SYMBOL_GPL(sysfs_create_dir);
-EXPORT_SYMBOL_GPL(sysfs_remove_dir);
-EXPORT_SYMBOL_GPL(sysfs_rename_dir);
-- 
1.2.4


