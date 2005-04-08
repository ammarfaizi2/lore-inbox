Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVDHAsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVDHAsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVDHAsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:48:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:37585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262639AbVDHAss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:48:48 -0400
Date: Thu, 7 Apr 2005 17:49:20 -0700
From: Nick Wilson <njw@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
Subject: [PATCH 2/6] include/linux/kernel.h: use generic round_up_pow2() macro
Message-ID: <20050408004920.GC4260@njw.pdx.osdl.net>
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


 kernel.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/linux/kernel.h
===================================================================
--- linux.orig/include/linux/kernel.h	2005-04-07 15:44:05.000000000 -0700
+++ linux/include/linux/kernel.h	2005-04-07 15:44:53.000000000 -0700
@@ -28,7 +28,7 @@ extern const char linux_banner[];
 #define STACK_MAGIC	0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
+#define ALIGN		round_up_pow2
 
 #define	KERN_EMERG	"<0>"	/* system is unusable			*/
 #define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
_
