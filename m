Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264978AbSKUWX0>; Thu, 21 Nov 2002 17:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSKUWX0>; Thu, 21 Nov 2002 17:23:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11648 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264978AbSKUWXX>;
	Thu, 21 Nov 2002 17:23:23 -0500
Date: Thu, 21 Nov 2002 14:30:31 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Use min_t() instead of min() in fs/ntfs/unistr.c
Message-ID: <20021121223031.GC1431@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change removes a "duplicate 'const'" compiler warning.

diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	Thu Nov 21 13:51:26 2002
+++ b/fs/ntfs/unistr.c	Thu Nov 21 13:51:26 2002
@@ -99,7 +99,7 @@
 	u32 cnt, min_len;
 	uchar_t c1, c2;
 
-	min_len = min(name1_len, name2_len);
+	min_len = min_t(const u32, name1_len, name2_len);
 	for (cnt = 0; cnt < min_len; ++cnt) {
 		c1 = le16_to_cpu(*name1++);
 		c2 = le16_to_cpu(*name2++);
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
