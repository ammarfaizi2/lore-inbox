Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWANWRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWANWRi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWANWRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:17:38 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:5334 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751322AbWANWRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:17:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=XQrxNRBkCuSm2BhLhPmi/8JDZp3C82vq8LoUgNEXfE+AXY6SzBXOg8hSEpQXiXEWefuB0nAwwAupk77YhRTwWQqOaiMbpzgmoDAkLYhPP9eo5Ocq+02rF6kXuJ8P4UponGBZba2y4P/xZ4bnZL2t4e1Ejv4dDhL72iI8dFOV8e4=
Date: Sun, 15 Jan 2006 01:34:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ian Molton <spyro@f2s.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: add L1_CACHE_SHIFT
Message-ID: <20060114223448.GA8002@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix reiserfs compilation as a side effect =)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm26/cache.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/asm-arm26/cache.h
+++ b/include/asm-arm26/cache.h
@@ -4,7 +4,8 @@
 #ifndef __ASMARM_CACHE_H
 #define __ASMARM_CACHE_H
 
-#define        L1_CACHE_BYTES  32
+#define        L1_CACHE_SHIFT  5
+#define        L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)
 #define        L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 #define        SMP_CACHE_BYTES L1_CACHE_BYTES
 

