Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933247AbWFZXLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbWFZXLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWFZXLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:11:01 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:16567 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933250AbWFZWi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 31/32] [Suspend2] Suspend block io ops.
Date: Tue, 27 Jun 2006 08:38:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223854.4376.28383.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the structure that the writers use to access the functions in this
file.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index f93d985..9339826 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -1035,3 +1035,23 @@ static int write_header_chunk_finish(voi
 		-1, 0, test_debug_state(SUSPEND_HEADER)) ? -EIO : 0;
 }
 
+struct suspend_bio_ops suspend_bio_ops = {
+	.bdev_page_io = suspend_bdev_page_io,
+	.check_io_stats = suspend_check_io_stats,
+	.reset_io_stats = suspend_reset_io_stats,
+	.finish_all_io = suspend_finish_all_io,
+	.prepare_readahead = suspend_prepare_readahead,
+	.cleanup_readahead = suspend_cleanup_readahead,
+	.readahead_pages = suspend_readahead_pages,
+	.readahead_ready = suspend_readahead_ready,
+	.forward_one_page = forward_one_page,
+	.set_extra_page_forward = set_extra_page_forward,
+	.set_devinfo = suspend_set_devinfo,
+	.read_chunk = suspend_bio_read_chunk,
+	.write_chunk = suspend_write_chunk,
+	.rw_init = suspend_rw_init,
+	.rw_cleanup = suspend_rw_cleanup,
+	.rw_header_chunk = suspend_rw_header_chunk,
+	.write_header_chunk_finish = write_header_chunk_finish,
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
