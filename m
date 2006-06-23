Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752057AbWFWVGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbWFWVGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWFWVGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:06:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:28220 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752057AbWFWVGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:06:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=nWnG/vfLX4r+k4s3myirqWbF8LwSxNsDhIZVk2V0WiDFCqsmnoeZsqFj7qUA7UJkIYQop9/FvyENYDkJ5uUPiBDVX19fT4O0MK8NURacRV8Ycud+B9f9cbevN0Lam13Hd/OtKhJmVuJ3oehw03XGIMPuGygD3v/gbiXvuMM6AnU=
Date: Sat, 24 Jun 2006 01:06:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: [PATCH] Fix "biovec-(256)" in /proc/slabinfo
Message-ID: <20060623210647.GA16360@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix "biovec-(256)" in /proc/slabinfo

Stringify does what it was told to do.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/bio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -47,7 +47,7 @@ #else
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_PAGES		(256)
+#define BIO_MAX_PAGES		256
 #define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
 #define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> 9)
 

