Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbUL3CPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUL3CPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUL3CPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:15:12 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:50354 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261516AbUL3COP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:14:15 -0500
Message-ID: <41D3646F.5050408@drzeus.cx>
Date: Thu, 30 Dec 2004 03:14:07 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-11483-1104372920-0001-2"
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] MMC block removable flag
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-11483-1104372920-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A MMC card is a highly removable device. This patch makes the block 
layer part of the MMC layer set the removable flag.

--
Pierre

--=_hades.drzeus.cx-11483-1104372920-0001-2
Content-Type: text/x-patch; name="mmc-removable.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-removable.patch"

Index: linux-wbsd/drivers/mmc/mmc_block.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc_block.c	(revision 99)
+++ linux-wbsd/drivers/mmc/mmc_block.c	(revision 100)
@@ -384,6 +384,7 @@
 		md->disk->private_data = md;
 		md->disk->queue = md->queue.queue;
 		md->disk->driverfs_dev = &card->dev;
+		md->disk->flags |= GENHD_FL_REMOVABLE;
 
 		sprintf(md->disk->disk_name, "mmcblk%d", devidx);
 		sprintf(md->disk->devfs_name, "mmc/blk%d", devidx);

--=_hades.drzeus.cx-11483-1104372920-0001-2--
