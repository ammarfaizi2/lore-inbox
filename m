Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVFASgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFASgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVFASG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:06:27 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:56029 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261525AbVFASEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:04:06 -0400
Date: Wed, 1 Jun 2005 20:04:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/11] s390: cmm sender parameter visibility.
Message-ID: <20050601180402.GH6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/11] s390: cmm sender parameter visibility.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Make cmm module parameter "sender" visible in sysfs.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/cmm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2005-06-01 19:42:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2005-06-01 19:43:19.000000000 +0200
@@ -21,7 +21,7 @@
 #include <asm/uaccess.h>
 
 static char *sender = "VMRMSVM";
-module_param(sender, charp, 0);
+module_param(sender, charp, 0400);
 MODULE_PARM_DESC(sender,
 		 "Guest name that may send SMSG messages (default VMRMSVM)");
 
