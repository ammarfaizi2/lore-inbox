Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWFZW4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWFZW4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933301AbWFZWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:40:35 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30391 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933302AbWFZWka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:30 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 25/35] [Suspend2] Does a filewriter image exist?
Date: Tue, 27 Jun 2006 08:40:28 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224027.4685.21396.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return whether an image exists at the current resume2= location.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 04f9cd0..5a1bfe6 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -775,3 +775,16 @@ static int filewriter_invalidate_image(v
 	return result;
 }
 
+/*
+ * Image_exists
+ *
+ */
+
+static int filewriter_image_exists(void)
+{
+	if (!filewriter_target_bdev)
+		reopen_resume_devt();
+
+	return filewriter_signature_op(GET_IMAGE_EXISTS);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
