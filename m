Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265049AbSJWPYX>; Wed, 23 Oct 2002 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265050AbSJWPYX>; Wed, 23 Oct 2002 11:24:23 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:51726 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265049AbSJWPYW>; Wed, 23 Oct 2002 11:24:22 -0400
Date: Wed, 23 Oct 2002 09:26:37 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/10] 2.5.44 cciss zero cylinders too
Message-ID: <20021023092637.B14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 10
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44

DESC
Zero out cylinders when zeroing out other disk info.


 drivers/block/cciss.c |    1 +
 1 files changed, 1 insertion

--- linux-2.5.44/drivers/block/cciss.c~zero_cyls	Mon Oct 21 12:05:12 2002
+++ linux-2.5.44-root/drivers/block/cciss.c	Mon Oct 21 12:05:12 2002
@@ -808,6 +808,7 @@ static int deregister_disk(int ctlr, int
 	/* zero out the disk size info */ 
 	h->drv[logvol].nr_blocks = 0;
 	h->drv[logvol].block_size = 0;
+	h->drv[logvol].cylinders = 0;
 	h->drv[logvol].LunID = 0;
 	return(0);
 }

.
