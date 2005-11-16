Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbVKPXAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbVKPXAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbVKPXAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:00:40 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:59107
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S1030559AbVKPXAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:00:20 -0500
Date: Wed, 16 Nov 2005 23:00:13 +0000
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/3] pfn_to_pgdat not used in common code
Message-ID: <20051116230013.GA16480@shadowen.org>
References: <exportbomb.1132181992@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1132181992@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_to_pgdat not used in common code

pfn_to_pgdat() isn't used in common code.  Remove definition.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 mmzone.h |    5 -----
 1 file changed, 5 deletions(-)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -607,11 +607,6 @@ static inline int pfn_valid(unsigned lon
 #define pfn_to_nid		early_pfn_to_nid
 #endif
 
-#define pfn_to_pgdat(pfn)						\
-({									\
-	NODE_DATA(pfn_to_nid(pfn));					\
-})
-
 #define early_pfn_valid(pfn)	pfn_valid(pfn)
 void sparse_init(void);
 #else
