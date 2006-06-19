Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWFSM0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWFSM0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWFSMZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932422AbWFSMZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:19 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/15] frv: Add missing qualifier to memcpy_fromio() prototype
Date: Mon, 19 Jun 2006 13:25:12 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122512.10060.20373.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The memcpy_fromio() function should have a const qualifier on its source
pointer.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-frv/io.h b/include/asm-frv/io.h
index 0c18453..58c8f5b 100644
--- a/include/asm-frv/io.h
+++ b/include/asm-frv/io.h
@@ -117,7 +117,7 @@ static inline void memset_io(volatile vo
 	memset((void __force *) addr, val, count);
 }
 
-static inline void memcpy_fromio(void *dst, volatile void __iomem *src, int count)
+static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
 {
 	memcpy(dst, (void __force *) src, count);
 }

