Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWEYB3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWEYB3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWEYB1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31118 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964823AbWEYB1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:03 -0400
Message-Id: <20060525003421.022340000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:47 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] use c99 initializer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/processor.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6-mm/include/asm-m68k/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/processor.h
+++ linux-2.6-mm/include/asm-m68k/processor.h
@@ -71,10 +71,10 @@ struct thread_struct {
 };
 
 #define INIT_THREAD  {							\
-	ksp:	sizeof(init_stack) + (unsigned long) init_stack,	\
-	sr:	PS_S,							\
-	fs:	__KERNEL_DS,						\
-	info:	INIT_THREAD_INFO(init_task)				\
+	.ksp	= sizeof(init_stack) + (unsigned long) init_stack,	\
+	.sr	= PS_S,							\
+	.fs	= __KERNEL_DS,						\
+	.info	= INIT_THREAD_INFO(init_task),				\
 }
 
 /*

--

