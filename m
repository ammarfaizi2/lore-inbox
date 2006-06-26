Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933259AbWFZWiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbWFZWiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbWFZWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:15031 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933253AbWFZWir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:38:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 28/32] [Suspend2] Write a page in the image proper.
Date: Tue, 27 Jun 2006 08:38:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223845.4376.79613.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Write a page in the image proper to storage.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index 374a861..f881fc7 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -956,3 +956,8 @@ static int suspend_rw_cleanup(int rw)
 	return 0;
 }
 
+static int suspend_write_chunk(struct page *buffer_page)
+{
+	return suspend_rw_page(WRITE, buffer_page, -1, 0, 0);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
