Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933302AbWFZW5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933302AbWFZW5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933310AbWFZW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:56:35 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30903 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933304AbWFZWke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:34 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 26/35] [Suspend2] Filewriter mark that attempted to resume.
Date: Tue, 27 Jun 2006 08:40:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224030.4685.28939.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the flag in an image header that says we've tried to resume before.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 5a1bfe6..20d0807 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -788,3 +788,14 @@ static int filewriter_image_exists(void)
 	return filewriter_signature_op(GET_IMAGE_EXISTS);
 }
 
+/*
+ * Mark resume attempted.
+ *
+ * Record that we tried to resume from this image.
+ */
+
+static void filewriter_mark_resume_attempted(void)
+{
+	filewriter_signature_op(MARK_RESUME_ATTEMPTED);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
