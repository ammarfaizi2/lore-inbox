Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVFUQoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVFUQoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVFUQb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:31:57 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:27895 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262183AbVFUQ2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:28:31 -0400
Date: Tue, 21 Jun 2005 18:28:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 11/16] s390: cmm sender parameter visibility.
Message-ID: <20050621162833.GK6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 11/16] s390: cmm sender parameter visibility.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Make cmm module parameter "sender" visible in sysfs.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/cmm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2005-06-21 17:36:52.000000000 +0200
@@ -21,7 +21,7 @@
 #include <asm/uaccess.h>
 
 static char *sender = "VMRMSVM";
-module_param(sender, charp, 0);
+module_param(sender, charp, 0400);
 MODULE_PARM_DESC(sender,
 		 "Guest name that may send SMSG messages (default VMRMSVM)");
 
