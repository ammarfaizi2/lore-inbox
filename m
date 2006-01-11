Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWAKMyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWAKMyc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWAKMyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:54:32 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:64950 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751469AbWAKMyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:54:32 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 2.6.15] do_truncate() call fix in tiny-shmem.c
Date: Wed, 11 Jan 2006 12:54:18 +0000
To: mpm@selenic.com
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060111125418.13276.29099.stgit@localhost.localdomain>
X-OriginalArrivalTime: 11 Jan 2006 12:54:19.0095 (UTC) FILETIME=[22D20E70:01C616AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This is a simple patch to adapt tiny-shmem.c to the new do_truncate()
prototype.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 mm/tiny-shmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/tiny-shmem.c b/mm/tiny-shmem.c
index cdc6d43..f9d6a9c 100644
--- a/mm/tiny-shmem.c
+++ b/mm/tiny-shmem.c
@@ -90,7 +90,7 @@ struct file *shmem_file_setup(char *name
 	file->f_mode = FMODE_WRITE | FMODE_READ;
 
 	/* notify everyone as to the change of file size */
-	error = do_truncate(dentry, size, file);
+	error = do_truncate(dentry, size, 0, file);
 	if (error < 0)
 		goto close_file;
 

