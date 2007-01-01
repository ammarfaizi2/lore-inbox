Return-Path: <linux-kernel-owner+w=401wt.eu-S1754362AbXAAVx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbXAAVx4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754370AbXAAVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:53:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:9403 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbXAAVxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:53:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Lmhc7ezjlXs/CcCZ8kbiUTCzY8CWMY8mdjqrpLt4m3OO4sqaT5ZlB0T0GKPOJ5NS4dh/e6uXDX9Oh4/5H7PE0veW3iUIbO948kvjNJQpXfphPfrrnt1VnS4JTyVCmMZE4bW3/rrTYbZ4plHsffzpj2D7a6tBn2tGfWtJxEOpbLc=
Date: Mon, 1 Jan 2007 13:53:47 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [RESEND] include/linux/slab.h: new KFREE() macro.
Message-Id: <20070101135347.b036d473.amit2030@gmail.com>
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
