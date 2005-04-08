Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVDHAsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVDHAsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVDHAsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:48:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:30417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262620AbVDHAsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:48:03 -0400
Date: Thu, 7 Apr 2005 17:48:35 -0700
From: Nick Wilson <njw@osdl.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, rddunlap@osdl.org
Subject: [PATCH 1/6] include/linux/kernel.h: use generic round_up_pow2() macro
Message-ID: <20050408004835.GB4260@njw.pdx.osdl.net>
References: <20050408004428.GA4260@njw.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408004428.GA4260@njw.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Wilson <njw@osdl.org>

Add a generic macro to kernel.h to round up to the next multiple of n.

Signed-off-by: Nick Wilson <njw@osdl.org>
---


 kernel.h |    5 +++++
 1 files changed, 5 insertions(+)

Index: linux/include/linux/kernel.h
===================================================================
--- linux.orig/include/linux/kernel.h	2005-04-07 15:13:56.000000000 -0700
+++ linux/include/linux/kernel.h	2005-04-07 15:47:15.000000000 -0700
@@ -246,6 +246,11 @@ extern void dump_stack(void);
 #define max_t(type,x,y) \
 	({ type __x = (x); type __y = (y); __x > __y ? __x: __y; })
 
+/*
+ * Round x up to the next multiple of n.
+ * n must be a power of 2. 
+ */
+#define round_up_pow2(x,n) (((x) + (n) - 1) & ~((n) - 1))
 
 /**
  * container_of - cast a member of a structure out to the containing structure
_
