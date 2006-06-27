Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933415AbWF0ElE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415AbWF0ElE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933418AbWF0ElB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:01 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:38363 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933414AbWF0Eku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:50 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/13] [Suspend2] Get the amount of memory needed by the storage manager.
Date: Tue, 27 Jun 2006 14:40:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044048.14778.59731.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the amount of memory needed by the storage manager. Note that this is
just the storage needed while running, not the grand total.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index 714e95e..e31623a 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -170,3 +170,9 @@ static void usm_load_config_info(char *b
 	memcpy(usm_helper_data.program, buf, size);
 }
 
+static unsigned long usm_memory_needed(void)
+{
+	/* ball park figure of 32 pages */
+	return (32 * PAGE_SIZE);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
