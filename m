Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSDSLxg>; Fri, 19 Apr 2002 07:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDSLxf>; Fri, 19 Apr 2002 07:53:35 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:18831 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S311749AbSDSLxf> convert rfc822-to-8bit;
	Fri, 19 Apr 2002 07:53:35 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Patch for unresolvedsSymbol <blk_max_pfn> in SCSI module 
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 19 Apr 2002 13:53:23 +0200
Message-ID: <2F315604E7A2184FAFC11E6AD36E4C4B0E332B@boebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unresolved Symbol blk_max_pfn in SCSI module 
Thread-Index: AcHnkjkK2WJEmFNmEdaCJgCgyel4qQ==
From: <Dirk.Uffmann@nokia.com>
To: <linux-kernel@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 19 Apr 2002 11:53:25.0013 (UTC) FILETIME=[CFC82450:01C1E798]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an "Unresolved Symbol" message when depmod is invoked 
for SCSI module caused by a missing EXPORT statement.

PATCH FOLLOWS
KernelVersion:2.5.8-rmk1
--- linux_2.5.8-rmk1_orginal/drivers/block/ll_rw_blk.c  Fri Apr 19 11:30:02 2002
+++ linux_2.5.8-rmk1/drivers/block/ll_rw_blk.c  Wed Apr 17 14:05:57 2002
@@ -1768,6 +1768,7 @@
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
 EXPORT_SYMBOL(blk_attempt_remerge);
+EXPORT_SYMBOL(blk_max_pfn);
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_queue_max_sectors);
 EXPORT_SYMBOL(blk_queue_max_phys_segments);
