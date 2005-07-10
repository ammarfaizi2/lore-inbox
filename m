Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVGJTnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVGJTnY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGJTmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:42:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:11155 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261885AbVGJTf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:58 -0400
Date: Sun, 10 Jul 2005 19:35:58 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 50/82] remove linux/version.h from drivers/scsi/sg.c
Message-ID: <20050710193558.50.eKJcUZ3600.2247.olh@nectarine.suse.de>
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

drivers/scsi/sg.c |    4 ----
1 files changed, 4 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/sg.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/sg.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/sg.c
@@ -67,10 +67,6 @@ static int sg_proc_init(void);
static void sg_proc_cleanup(void);
#endif

-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif				/* LINUX_VERSION_CODE */
-
#define SG_ALLOW_DIO_DEF 0
#define SG_ALLOW_DIO_CODE /* compile out by commenting this define */

