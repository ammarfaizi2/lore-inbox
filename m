Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWFZXeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWFZXeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933159AbWFZWfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:10 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34207 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933152AbWFZWe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/20] [Suspend2] Get the real number of free pages (incl. pcp).
Date: Tue, 27 Jun 2006 08:34:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223455.4050.26179.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the total number of free pages, including pcp pages.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 9f6e96d..cb1a3da 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -73,3 +73,11 @@ static long num_pcp_pages(void)
 	return result;
 }
 
+/*
+ * Number of free pages, including pcp pages.
+ */
+long real_nr_free_pages(void)
+{
+	return nr_free_pages() + num_pcp_pages();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
