Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUGBMvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUGBMvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUGBMvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:51:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20474 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263725AbUGBMu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:50:58 -0400
Date: Fri, 2 Jul 2004 18:30:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: linux-osdl@osdl.org
Subject: [PATCH 0/22] fsaio, pipe aio and aio poll upgraded to 2.6.7
Message-ID: <20040702130030.GA4256@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its been a while since I last posted the retry based AIO patches
that I've been accumulating. Janet Morgan recently brought
the whole patchset up-to to 2.6.7.

The patchset contains modifications and fixes to the AIO core
to support the full retry model, an implementation of AIO
support for buffered filesystem AIO reads and O_SYNC writes
(the latter courtesy O_SYNC speedup changes from Andrew Morton),
an implementation of AIO reads and writes to pipes (from
Chris Mason) and AIO poll (again from Chris Mason).

Full retry infrastructure and fixes
[1] aio-retry.patch
[2] 4g4g-aio-hang-fix.patch
[3] aio-retry-elevated-refcount.patch
[4] aio-splice-runlist.patch

FS AIO read
[5] aio-wait-page.patch
[6] aio-fs_read.patch
[7] aio-upfront-readahead.patch

AIO for pipes
[8] aio-cancel-fix.patch
[9] aio-read-immediate.patch
[10] aio-pipe.patch
[11] aio-context-switch.patch

Concurrent O_SYNC write speedups using radix-tree walks
[12] writepages-range.patch
[13] fix-writeback-range.patch
[14] fix-writepages-range.patch
[15] fdatawrite-range.patch
[16] O_SYNC-speedup.patch

AIO O_SYNC write
[17] aio-wait_on_page_writeback_range.patch
[18] aio-O_SYNC.patch
[19] O_SYNC-write-fix.patch

AIO poll
[20] aio-poll.patch

Infrastructure fixes
[21] aio-putioctx-flushworkqueue.patch
[22] aio-context-stall.patch

Next steps: Code changes for filtered wakeups per wli

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

