Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030702AbWF0Er5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030702AbWF0Er5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWF0Erb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:47:31 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51675 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933439AbWF0EmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:18 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 19/21] [Suspend2] Operations for userspace interface module.
Date: Tue, 27 Jun 2006 14:42:17 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044216.14883.78091.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the operations for the core to store our configuration information
in the image header and know how much memory is needed for work.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 4955d5f..3f2f549 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -777,3 +777,14 @@ static struct suspend_proc_data proc_par
 #endif
 };
 
+static struct suspend_module_ops userui_ops = {
+	.type				= MISC_MODULE,
+	.name				= "Userspace UI Support",
+	.module				= THIS_MODULE,
+#ifdef CONFIG_NET
+	.storage_needed			= userui_storage_needed,
+	.save_config_info		= userui_save_config_info,
+	.load_config_info		= userui_load_config_info,
+	.memory_needed			= userui_memory_needed,
+#endif
+};

--
Nigel Cunningham		nigel at suspend2 dot net
