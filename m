Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSKUW0e>; Thu, 21 Nov 2002 17:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbSKUWZW>; Thu, 21 Nov 2002 17:25:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13184 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265003AbSKUWYy>;
	Thu, 21 Nov 2002 17:24:54 -0500
Date: Thu, 21 Nov 2002 14:31:59 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Use min_t() instead of min() in mm/swap_state.c
Message-ID: <20021121223159.GE1431@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change removes a "duplicate 'const'" compiler warning.

diff -Nru a/mm/swap_state.c b/mm/swap_state.c
--- a/mm/swap_state.c	Thu Nov 21 13:51:26 2002
+++ b/mm/swap_state.c	Thu Nov 21 13:51:26 2002
@@ -296,7 +296,7 @@
 	struct page **pagep = pages;
 
 	while (nr) {
-		int todo = min(chunk, nr);
+		int todo = min_t(const int, chunk, nr);
 		int i;
 
 		for (i = 0; i < todo; i++)
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
