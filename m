Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263090AbSJBOiS>; Wed, 2 Oct 2002 10:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263101AbSJBOiS>; Wed, 2 Oct 2002 10:38:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62199 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263090AbSJBOiR>;
	Wed, 2 Oct 2002 10:38:17 -0400
Subject: [Trivial 2.5 patch] ips.c remove tqueue.h
From: Paul Larson <plars@linuxtestproject.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Oct 2002 09:39:45 -0500
Message-Id: <1033569586.28106.3.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ips.c driver wasn't compiling and broke my nightly run last night. 
It doesn't look like they were even using task queues though, so
removing the include fixed it.  Tested that it compiles and boots with
this.

Please apply.

-Paul Larson

--- linux-2.5/drivers/scsi/ips.c	Thu Aug 22 12:02:43 2002
+++ linux-ipswq/drivers/scsi/ips.c	Wed Oct  2 10:00:50 2002
@@ -164,7 +164,6 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/reboot.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 
 #include <linux/blk.h>



