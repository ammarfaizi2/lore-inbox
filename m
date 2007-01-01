Return-Path: <linux-kernel-owner+w=401wt.eu-S1754605AbXAAAR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbXAAAR6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 19:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbXAAAR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 19:17:58 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:39538 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbXAAAR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 19:17:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=dj/pIn69e3bF6BxxyFxwu1L9GoSfGzE8h1sPezX79RJvxFOMYXCGXkigjGRo4wQ28DqlUvQ7s8wqo9dc+Ka/gGV+oFjAqKCuSEm9AJM6KKsmOpsOU+tjyto3qgx8J4zIbv7i95/LZ6oeqv2VcxO7Pwlqdzlv3rYh9i+Z7Fw+MCc=
Date: Sun, 31 Dec 2006 16:17:49 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] include/linux/slab.h: new KFREE() macro.
Message-Id: <20061231161749.06e7f746.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: new KFREE() macro to set the variable NULL after freeing it.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1ef822e..28da74c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -75,6 +75,12 @@ void *__kzalloc(size_t, gfp_t);
 void kfree(const void *);
 unsigned int ksize(const void *);
 
+#define KFREE(x)		\
+	do {			\
+		kfree(x);	\
+		x = NULL;	\
+	} while(0)
+
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
  * @n: number of elements.
