Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVDHAue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVDHAue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVDHAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:50:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:57297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262640AbVDHAti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:49:38 -0400
Date: Thu, 7 Apr 2005 17:50:10 -0700
From: Nick Wilson <njw@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
Subject: [PATCH 3/6] include/linux/a.out.h: use generic round_up_pow2() macro
Message-ID: <20050408005010.GD4260@njw.pdx.osdl.net>
References: <20050408004428.GA4260@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408004428.GA4260@njw.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Wilson <njw@osdl.org>

Use the generic round_up_pow2() instead of a custom rounding method.

Signed-off-by: Nick Wilson <njw@osdl.org>
---


 a.out.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/linux/a.out.h
===================================================================
--- linux.orig/include/linux/a.out.h	2005-04-07 15:37:22.000000000 -0700
+++ linux/include/linux/a.out.h	2005-04-07 15:45:34.000000000 -0700
@@ -138,7 +138,7 @@ enum machine_type {
 #endif
 #endif
 
-#define _N_SEGMENT_ROUND(x) (((x) + SEGMENT_SIZE - 1) & ~(SEGMENT_SIZE - 1))
+#define _N_SEGMENT_ROUND(x) round_up_pow2(x, SEGMENT_SIZE)
 
 #define _N_TXTENDADDR(x) (N_TXTADDR(x)+(x).a_text)
 
_
