Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275680AbRJFUIO>; Sat, 6 Oct 2001 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275676AbRJFUIE>; Sat, 6 Oct 2001 16:08:04 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:39064 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S275680AbRJFUH5>; Sat, 6 Oct 2001 16:07:57 -0400
Subject: [PATCH] 2.4.10-ac7 one liner cleanup
To: alan@lxorguk.ukuu.org.uk
Date: Sat, 6 Oct 2001 21:08:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15pxkG-0001dj-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

There is a superfluous declaration of __add_page_to_hash_queue() in
include/linux/pagemap.h. There is no reference to this function anywhere
in the current source tree. Below patch removes it.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- cleanup-2.4.10-ac7 ---
--- linux-2.4.10-ac7-vanilla/include/linux/pagemap.h	Sat Oct  6 14:30:08 2001
+++ linux-2.4.10-ac7-aia1/include/linux/pagemap.h	Sat Oct  6 14:36:06 2001
@@ -81,8 +81,6 @@
 #define find_lock_page(mapping, index) \
 	__find_lock_page(mapping, index, page_hash(mapping, index))
 
-extern void __add_page_to_hash_queue(struct page * page, struct page **p);
-
 extern void add_to_page_cache(struct page * page, struct address_space *mapping, unsigned long index);
 extern void add_to_page_cache_locked(struct page * page, struct address_space *mapping, unsigned long index);
 

