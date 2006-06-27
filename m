Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030637AbWF0EiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbWF0EiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbWF0Eh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:37:57 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24278 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030619AbWF0Ehp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:45 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/13] [Suspend2] Compression memory and storage usage routines.
Date: Tue, 27 Jun 2006 14:37:44 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043743.14320.6281.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines to tell the core how much memory and space in the image header is
required for the compression support.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 6578e8c..b8005c7 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -399,4 +399,21 @@ static int suspend_compress_print_debug_
 	return len;
 }
 
+/* 
+ * suspend_compress_compression_memory_needed
+ *
+ * Tell the caller how much memory we need to operate during suspend/resume.
+ * Returns: Unsigned long. Maximum number of bytes of memory required for
+ * operation.
+ */
+static unsigned long suspend_compress_memory_needed(void)
+{
+	return 2 * PAGE_SIZE;
+}
+
+static unsigned long suspend_compress_storage_needed(void)
+{
+	return 4 * sizeof(unsigned long) + strlen(suspend_compressor_name) + 1;
+}
+
 

--
Nigel Cunningham		nigel at suspend2 dot net
