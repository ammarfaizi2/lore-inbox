Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316526AbSEWM34>; Thu, 23 May 2002 08:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316474AbSEWM2E>; Thu, 23 May 2002 08:28:04 -0400
Received: from imladris.infradead.org ([194.205.184.45]:40202 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316475AbSEWM0p>; Thu, 23 May 2002 08:26:45 -0400
Date: Thu, 23 May 2002 13:26:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (3/10)
Message-ID: <20020523132643.D24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused bh_kmap/bh_kunmap inlines from highmem.h.


--- 1.14/include/linux/highmem.h	Mon Mar 25 10:51:55 2002
+++ edited/include/linux/highmem.h	Thu May 23 14:18:04 2002
@@ -18,16 +18,6 @@
 extern void create_bounce(unsigned long pfn, int gfp, struct bio **bio_orig);
 extern void check_highmem_ptes(void);
 
-static inline char *bh_kmap(struct buffer_head *bh)
-{
-	return kmap(bh->b_page) + bh_offset(bh);
-}
-
-static inline void bh_kunmap(struct buffer_head *bh)
-{
-	kunmap(bh->b_page);
-}
-
 /*
  * remember to add offset! and never ever reenable interrupts between a
  * bio_kmap_irq and bio_kunmap_irq!!
