Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWF0EwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWF0EwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933423AbWF0ElX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:23 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:40411 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933414AbWF0ElE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/13] [Suspend2] Storage manager module ops.
Date: Tue, 27 Jun 2006 14:41:03 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044102.14778.20533.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define the operations that the core can use to access storage manager
functionality and data.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index c8f85db..885501b 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -284,3 +284,13 @@ static struct suspend_proc_data proc_par
 #endif
 };
 
+static struct suspend_module_ops usm_ops = {
+	.type				= MISC_MODULE,
+	.name				= "Userspace Storage Manager",
+	.module				= THIS_MODULE,
+	.storage_needed			= usm_storage_needed,
+	.save_config_info		= usm_save_config_info,
+	.load_config_info		= usm_load_config_info,
+	.memory_needed			= usm_memory_needed,
+};
+       

--
Nigel Cunningham		nigel at suspend2 dot net
