Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933348AbWFZWoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933348AbWFZWoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933347AbWFZWmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:50 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:54455 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933352AbWFZWmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:40 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 27/28] [Suspend2] Swapwriter ops.
Date: Tue, 27 Jun 2006 08:42:38 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224237.4975.9160.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Structure defining the swapwriter operations exported for use by the core.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index e210241..b04e2f3 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -1178,3 +1178,29 @@ static struct suspend_proc_data swapwrit
 	}
 };
 
+static struct suspend_module_ops swapwriterops = {
+	.type					= WRITER_MODULE,
+	.name					= "Swap Writer",
+	.module					= THIS_MODULE,
+	.memory_needed				= swapwriter_memory_needed,
+	.print_debug_info			= swapwriter_print_debug_stats,
+	.storage_needed				= swapwriter_storage_needed,
+	.initialise				= swapwriter_initialise,
+	.cleanup				= swapwriter_cleanup,
+
+	.noresume_reset	= swapwriter_noresume_reset,
+	.storage_available 	= swapwriter_storage_available,
+	.storage_allocated	= swapwriter_storage_allocated,
+	.release_storage	= swapwriter_release_storage,
+	.allocate_header_space	= swapwriter_allocate_header_space,
+	.allocate_storage	= swapwriter_allocate_storage,
+	.image_exists		= swapwriter_image_exists,
+	.mark_resume_attempted	= swapwriter_mark_resume_attempted,
+	.write_header_init	= swapwriter_write_header_init,
+	.write_header_cleanup	= swapwriter_write_header_cleanup,
+	.read_header_init	= swapwriter_read_header_init,
+	.read_header_cleanup	= swapwriter_read_header_cleanup,
+	.invalidate_image	= swapwriter_invalidate_image,
+	.parse_sig_location	= swapwriter_parse_sig_location,
+};
+       

--
Nigel Cunningham		nigel at suspend2 dot net
