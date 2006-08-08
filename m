Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWHHAUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWHHAUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWHHAUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:20:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54875 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932423AbWHHAUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=fllxc0I3MRkkqYN34Nd7z3SmnJ9EL4sDGwnmoT5jkByRS/vuK7ppgafNk17t5KsW0mlRIW13V+F4KOvWIQLsSi+N2n/Or6mHyBBV1G8lnpptFMwX/OoK+e/WO/qQ7NVyXt7W9zmydjoRtfWXQIOweSftLX7oBvawbm4XOxc0AhY=
Date: Tue, 8 Aug 2006 04:20:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Kazumoto Kojima <kkojima@rr.iij4u.or.jp>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] sh: fix FPN_START typo
Message-ID: <20060808002011.GA25557@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that it passes allmodconfig without it...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-sh/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/asm-sh/page.h
+++ b/include/asm-sh/page.h
@@ -104,7 +104,7 @@ #define page_to_phys(page)	(((page - mem
 
 /* PFN start number, because of __MEMORY_START */
 #define PFN_START		(__MEMORY_START >> PAGE_SHIFT)
-#define ARCH_PFN_OFFSET		(FPN_START)
+#define ARCH_PFN_OFFSET		(PFN_START)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_valid(pfn)		(((pfn) - PFN_START) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)

