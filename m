Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWF0FMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWF0FMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWF0Ehz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:25558 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030630AbWF0Ehx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:53 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/13] [Suspend2] Get expected compression ratio.
Date: Tue, 27 Jun 2006 14:37:51 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043749.14320.83656.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the expected compression ratio, set by the user.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 1398dc5..924d507 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -460,3 +460,20 @@ static void suspend_compress_load_config
 	return;
 }
 
+/* 
+ * suspend_expected_compression_ratio
+ * 
+ * Description:	Returns the expected ratio between data passed into this module
+ * 		and the amount of data output when writing.
+ * Returns:	100 if the module is disabled. Otherwise the value set by the
+ * 		user via our proc entry.
+ */
+
+int suspend_expected_compression_ratio(void)
+{
+	if (suspend_compression_ops.disabled)
+		return 100;
+	else
+		return 100 - suspend_expected_compression;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
