Return-Path: <linux-kernel-owner+w=401wt.eu-S1753153AbWL1KjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbWL1KjH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbWL1KjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:39:07 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:38194 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbWL1KjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:39:06 -0500
Date: Thu, 28 Dec 2006 11:39:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, melissah@us.ibm.com
Subject: [S390] Change max. buffer size for monwriter device.
Message-ID: <20061228103900.GA6270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Melissa Howland <melissah@us.ibm.com>

[S390] Change max. buffer size for monwriter device.

Reduce the max. buffer size for the monwriter device to prevent a
possible problem with the z/VM monitor service.

Signed-off-by: Melissa Howland <melissah@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monwriter.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/char/monwriter.c linux-2.6-patched/drivers/s390/char/monwriter.c
--- linux-2.6/drivers/s390/char/monwriter.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/monwriter.c	2006-12-28 00:33:35.000000000 +0100
@@ -23,7 +23,7 @@
 #include <asm/appldata.h>
 #include <asm/monwriter.h>
 
-#define MONWRITE_MAX_DATALEN	4024
+#define MONWRITE_MAX_DATALEN	4010
 
 static int mon_max_bufs = 255;
 static int mon_buf_count;
