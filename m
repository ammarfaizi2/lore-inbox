Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933197AbWFZWgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933197AbWFZWgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933110AbWFZWgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:23 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:44959 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933184AbWFZWgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/19] [Suspend2] Attempt to parse resume device (wrapped).
Date: Tue, 27 Jun 2006 08:36:08 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223607.4219.99910.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a version that attempts to parse the resume2= parameter, but wraps the
call in calls to enable and disable any storage (such as network storage)
configured via the userspace storage manager.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index 52f538d..bfe4468 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -104,3 +104,10 @@ cleanup:
 	return returning;
 }
 
+void attempt_to_parse_resume_device2(void)
+{
+	suspend_prepare_usm();
+	suspend_attempt_to_parse_resume_device();
+	suspend_cleanup_usm();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
