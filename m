Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVGJVgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVGJVgl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGJTjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41948 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261807AbVGJTfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:48 -0400
Date: Sun, 10 Jul 2005 19:35:47 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 39/82] remove linux/version.h from drivers/scsi/ibmmca.c
Message-ID: <20050710193547.39.URTrWX3308.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/scsi/ibmmca.c |    6 ------
1 files changed, 6 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/ibmmca.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/ibmmca.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/ibmmca.c
@@ -18,12 +18,6 @@
*/

#include <linux/config.h>
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,45)
-#error "This driver works only with kernel 2.5.45 or higher!"
-#endif
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>
