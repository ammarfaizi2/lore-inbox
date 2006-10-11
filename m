Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWJKVHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWJKVHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWJKVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:44191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161399AbWJKVGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:09 -0400
Date: Wed, 11 Oct 2006 14:05:50 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 29/67] Fix m68knommu exported headers
Message-ID: <20061011210550.GD16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0007-Fix-m68knommu-exported-headers.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

Just clean up asm/page.h

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-m68knommu/page.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.18.orig/include/asm-m68knommu/page.h
+++ linux-2.6.18/include/asm-m68knommu/page.h
@@ -1,6 +1,7 @@
 #ifndef _M68KNOMMU_PAGE_H
 #define _M68KNOMMU_PAGE_H
 
+#ifdef __KERNEL__
 
 /* PAGE_SHIFT determines the page size */
 
@@ -8,8 +9,6 @@
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
-#ifdef __KERNEL__
-
 #include <asm/setup.h>
 
 #ifndef __ASSEMBLY__
@@ -76,8 +75,8 @@ extern unsigned long memory_end;
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
+
 #endif /* _M68KNOMMU_PAGE_H */

--
