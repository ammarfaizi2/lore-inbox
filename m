Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUIKFXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUIKFXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 01:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIKFXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 01:23:25 -0400
Received: from ozlabs.org ([203.10.76.45]:26340 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267592AbUIKFXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 01:23:24 -0400
Date: Sat, 11 Sep 2004 15:20:00 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc32] Remove -Wno-uninitialized
Message-ID: <20040911052000.GC6005@krispykreme>
References: <200409101520.12653.jbarnes@engr.sgi.com> <20040911043303.GB6005@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911043303.GB6005@krispykreme>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Remove -Wno-uninitialized on ppc32 too. Ive just found a number of
real bugs on ppc64 by doing the same.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== arch/ppc/Makefile 1.63 vs edited =====
--- 1.63/arch/ppc/Makefile	Wed Sep  1 10:00:00 2004
+++ edited/arch/ppc/Makefile	Sat Sep 11 15:17:30 2004
@@ -24,7 +24,7 @@
 CPPFLAGS	+= -Iarch/$(ARCH)
 AFLAGS		+= -Iarch/$(ARCH)
 CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe \
-		-ffixed-r2 -Wno-uninitialized -mmultiple
+		-ffixed-r2 -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
 
 CHECKFLAGS	+= -D__powerpc__=1
