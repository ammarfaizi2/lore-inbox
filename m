Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933336AbWFZWln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbWFZWln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWFZWlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:22 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34999 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933273AbWFZWlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 34/35] [Suspend2] Filewriter ops.
Date: Tue, 27 Jun 2006 08:40:59 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224058.4685.15731.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the filewriter ops structure, which provides the core with access
to its functions.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 4ec51c2..56c7a76 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -1069,3 +1069,29 @@ static struct suspend_proc_data filewrit
 	}
 };
 
+static struct suspend_module_ops filewriterops = {
+	.type					= WRITER_MODULE,
+	.name					= "File Writer",
+	.module					= THIS_MODULE,
+	.print_debug_info			= filewriter_print_debug_stats,
+	.save_config_info			= filewriter_save_config_info,
+	.load_config_info			= filewriter_load_config_info,
+	.storage_needed				= filewriter_storage_needed,
+	.initialise				= filewriter_initialise,
+	.cleanup				= filewriter_cleanup,
+
+	.storage_available 	= filewriter_storage_available,
+	.storage_allocated	= filewriter_storage_allocated,
+	.release_storage	= filewriter_release_storage,
+	.allocate_header_space	= filewriter_allocate_header_space,
+	.allocate_storage	= filewriter_allocate_storage,
+	.image_exists		= filewriter_image_exists,
+	.mark_resume_attempted	= filewriter_mark_resume_attempted,
+	.write_header_init	= filewriter_write_header_init,
+	.write_header_cleanup	= filewriter_write_header_cleanup,
+	.read_header_init	= filewriter_read_header_init,
+	.read_header_cleanup	= filewriter_read_header_cleanup,
+	.invalidate_image	= filewriter_invalidate_image,
+	.parse_sig_location	= filewriter_parse_sig_location,
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
