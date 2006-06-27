Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933413AbWF0EyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413AbWF0EyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933421AbWF0ElI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:08 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:37339 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933412AbWF0Ekn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:43 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/13] [Suspend2] Get storage manager space needed in image header.
Date: Tue, 27 Jun 2006 14:40:42 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044041.14778.91751.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the amount of space in the image header needed by the storage manager.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index c007a8e..5fdcadd 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -148,3 +148,9 @@ static void storage_manager_simulate(voi
 	printk("--- Storage manager simulate ends ---\n");
 }
 #endif
+
+static unsigned long usm_storage_needed(void)
+{
+	return strlen(usm_helper_data.program);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
