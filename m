Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVKNV6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVKNV6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVKNVzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:55:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29845 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751281AbVKNVzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:16 -0500
Date: Mon, 14 Nov 2005 21:54:37 GMT
Message-Id: <200511142154.jAELsbqP007517@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 2/12] FS-Cache: Permit multiple inclusion of linux/pagevec.h
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes it possible to include linux/pagevec.h multiple times
without incurring errors due to duplicate definitions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 pagevec-hdr-ifndef-2614mm2.diff
 include/linux/pagevec.h |    5 +++++
 1 files changed, 5 insertions(+)

diff -uNrp linux-2.6.14-mm2/include/linux/pagevec.h linux-2.6.14-mm2-cachefs/include/linux/pagevec.h
--- linux-2.6.14-mm2/include/linux/pagevec.h	2005-01-04 11:13:55.000000000 +0000
+++ linux-2.6.14-mm2-cachefs/include/linux/pagevec.h	2005-11-14 16:23:41.000000000 +0000
@@ -5,6 +5,9 @@
  * pages.  A pagevec is a multipage container which is used for that.
  */
 
+#ifndef _LINUX_PAGEVEC_H
+#define _LINUX_PAGEVEC_H
+
 /* 14 pointers + two long's align the pagevec structure to a power of two */
 #define PAGEVEC_SIZE	14
 
@@ -83,3 +86,5 @@ static inline void pagevec_lru_add(struc
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
 }
+
+#endif /* _LINUX_PAGEVEC_H */
