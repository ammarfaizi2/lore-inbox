Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264861AbUDWQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbUDWQVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUDWQVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:21:38 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:8835 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264859AbUDWQVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:21:34 -0400
Date: Fri, 23 Apr 2004 12:22:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] typo in include/linux/compiler.h
In-Reply-To: <20040422130651.GB18358@logos.cnet>
Message-ID: <Pine.LNX.4.58.0404231219270.3745@montezuma.fsmlabs.com>
References: <20040422130651.GB18358@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Marcelo Tosatti wrote:

> Scott Feldman:
>   o Update MAINTAINERS with new e100/e100 maintainers
>
> Zwane Mwaikambo:
>   o fix module load with gcc3.3.3

Hello Marcelo,
	I appear to have missed a small fix, although it won't affect
anyone for a while to come;

--- linux-2.4-bk/include/linux/compiler.h	2004-04-23 12:17:12.292797432 -0400
+++ linux-2.4-bk/include/linux/compiler.h-patch	2004-04-23 12:18:11.923732152 -0400
@@ -14,7 +14,7 @@
 #define unlikely(x)	__builtin_expect((x),0)

 #if __GNUC__ > 3
-#define __attribute_used__	__attribute((__used__))
+#define __attribute_used__	__attribute__((__used__))
 #elif __GNUC__ == 3
 #if  __GNUC_MINOR__ >= 3
 # define __attribute_used__	__attribute__((__used__))
