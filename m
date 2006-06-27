Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030672AbWF0Eiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030672AbWF0Eiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030663AbWF0Eio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:44 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:31190 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030649AbWF0Ei2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:28 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/12] [Suspend2] Encryption debug stats.
Date: Tue, 27 Jun 2006 14:38:26 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043825.14437.79089.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
References: <20060627043803.14437.68085.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If encryption is enabled, add a message to the debug information to
indicate that it is enabled and which algorithm is being used.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/encryption.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/kernel/power/encryption.c b/kernel/power/encryption.c
index cd26e84..25db7ba 100644
--- a/kernel/power/encryption.c
+++ b/kernel/power/encryption.c
@@ -279,3 +279,21 @@ static int suspend_encrypt_read_chunk(st
 	return ret;
 }
 
+/* suspend_encrypt_print_debug_stats
+ *
+ * Description:	Print information to be recorded for debugging purposes into a
+ * 		buffer.
+ * Arguments:	buffer: Pointer to a buffer into which the debug info will be
+ * 			printed.
+ * 		size:	Size of the buffer.
+ * Returns:	Number of characters written to the buffer.
+ */
+static int suspend_encrypt_print_debug_stats(char *buffer, int size)
+{
+	int len;
+	
+	len = snprintf_used(buffer, size, "- Encryptor %s enabled.\n",
+			suspend_encryptor_name);
+	return len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
