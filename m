Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263440AbSJGVgM>; Mon, 7 Oct 2002 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263442AbSJGVgL>; Mon, 7 Oct 2002 17:36:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:28324 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263440AbSJGVgK>;
	Mon, 7 Oct 2002 17:36:10 -0400
Subject: [Trivial 2.5 patch] ips.c remove tqueue.h
From: Paul Larson <plars@linuxtestproject.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Oct 2002 16:36:26 -0500
Message-Id: <1034026587.15180.52.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the ips.c driver is still broken in 2.5.41 because of the
task queue removal.  Could you please apply this trivial patch so that
my nightly tests of the bk snapshot will run?

Thanks,
Paul Larson

--- linux-2.5/drivers/scsi/ips.c	Thu Aug 22 12:02:43 2002
+++ linux-ipswq/drivers/scsi/ips.c	Wed Oct  2 10:00:50 2002
@@ -164,7 +164,6 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/reboot.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 
 #include <linux/blk.h>



