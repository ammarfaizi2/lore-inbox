Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbUKEAzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbUKEAzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUKEAxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:53:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:5087 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262530AbUKEAtZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:25 -0500
X-Donotread: and you are reading this why?
Subject: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <20041105003542.GA31842@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:24 -0800
Message-Id: <10996157042090@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.1, 2004/11/03 13:50:35-08:00, maneesh@in.ibm.com

[PATCH] sysfs: fix sysfs backing store error path confusion

o sysfs_new_dirent to retrun 0 if kmalloc fails. Thanks to Milton Miller
  for spotting this.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-04 16:31:16 -08:00
+++ b/fs/sysfs/dir.c	2004-11-04 16:31:16 -08:00
@@ -56,7 +56,7 @@
 
 	sd = sysfs_new_dirent(parent_sd, element);
 	if (!sd)
-		return -ENOMEM;
+		return 0;
 
 	sd->s_mode = mode;
 	sd->s_type = type;

