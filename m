Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWGESDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWGESDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWGESDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:03:37 -0400
Received: from palrel11.hp.com ([156.153.255.246]:52906 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S964951AbWGESDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:03:37 -0400
Date: Wed, 5 Jul 2006 13:03:34 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Cc: hch@infradead.org, xfs@oss.sgi.com, nickolay@protei.ru,
       mmontour@bycast.com, iss_storagedev@hp.com
Subject: [PATCH 1/2] cciss: add BLKSSZGET back to 2.4 driver
Message-ID: <20060705180334.GA9656@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1/2

This patch adds BLKSSZGET into the cciss driver. Not sure why it isn't in
there. I'm sure it  used to be. :)

Thanks to Nicolay and others for reporting this.

Signed-off-by: Mike Miller <mike.miller@hp.com>
------------------------------------------------------------------------------------------
 cciss.c |    1 +
 1 files changed, 1 insertion(+)

diff -burNp linux-2.4.32.orig/drivers/block/cciss.c linux-2.4.32/drivers/block/cciss.c
--- linux-2.4.32.orig/drivers/block/cciss.c	2005-11-16 13:12:54.000000000 -0600
+++ linux-2.4.32/drivers/block/cciss.c	2006-07-05 12:54:41.000000000 -0500
@@ -740,6 +740,7 @@ static int cciss_ioctl(struct inode *ino
 	case BLKFLSBUF:
 	case BLKBSZSET:
 	case BLKBSZGET:
+	case BLKSSZGET:
 	case BLKROSET:
 	case BLKROGET:
 	case BLKRASET:
