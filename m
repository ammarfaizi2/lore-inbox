Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVKRQeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVKRQeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVKRQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:34:11 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:28083 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932334AbVKRQeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:34:10 -0500
Date: Fri, 18 Nov 2005 10:33:57 -0600
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, hpa@zytor.com,
       sitniko@infonet.ee
Subject: [PATCH 1/3] cciss: bug fix for hpacucli
Message-ID: <20051118163357.GA10928@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 3

This patch fixes a bug that breaks hpacucli, a command line interface
for the HP Array Config Utility. Without this fix the utility will
not detect any controllers in the system. I thought I had already fixed
this, but I guess not.

Thanks to all who reported the issue. Please consider this this inclusion.

Signed-off-by: Mike Miller

--------------------------------------------------------------------------------

 include/linux/cciss_ioctl.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/cciss_ioctl.h~cciss_fix_for_cli include/linux/cciss_ioctl.h
--- linux-2.6.14.2/include/linux/cciss_ioctl.h~cciss_fix_for_cli	2005-11-18 10:20:38.692304096 -0600
+++ linux-2.6.14.2-mikem/include/linux/cciss_ioctl.h	2005-11-18 10:21:14.112919344 -0600
@@ -10,8 +10,8 @@
 typedef struct _cciss_pci_info_struct
 {
 	unsigned char 	bus;
-	unsigned short	domain;
 	unsigned char 	dev_fn;
+	unsigned short	domain;
 	__u32 		board_id;
 } cciss_pci_info_struct; 
 
_
