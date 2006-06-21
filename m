Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWFUTtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWFUTtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWFUTtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:49:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9114 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030236AbWFUTtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:17 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/22] [PATCH] CCISS: add device symlink to the block cciss block devices in sysfs
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:46 -0700
Message-Id: <11509191721672-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191682051-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/cciss.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 1319d8f..25c3c4a 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -3237,6 +3237,7 @@ #endif /* CCISS_DEBUG */
 		disk->fops = &cciss_fops;
 		disk->queue = q;
 		disk->private_data = drv;
+		disk->driverfs_dev = &pdev->dev;
 		/* we must register the controller even if no disks exist */
 		/* this is for the online array utilities */
 		if(!drv->heads && j)
-- 
1.4.0

