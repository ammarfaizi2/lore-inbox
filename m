Return-Path: <linux-kernel-owner+willy=40w.ods.org-S379571AbUKBHVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S379571AbUKBHVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S379568AbUKBHVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:21:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:27603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S446876AbUKBHUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:20:18 -0500
Date: Tue, 2 Nov 2004 00:18:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 8/14] FRV: GP-REL data support
Message-Id: <20041102001824.3b16e203.akpm@osdl.org>
In-Reply-To: <200411011930.iA1JUL1K023209@warthog.cambridge.redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	<200411011930.iA1JUL1K023209@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



security/security.c: In function `do_security_initcalls':
security/security.c:41: warning: assignment from incompatible pointer type
security/security.c:42: warning: comparison of distinct pointer types lacks a cast


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/security/security.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN security/security.c~frv-gp-rel-data-support-fix security/security.c
--- 25/security/security.c~frv-gp-rel-data-support-fix	2004-11-01 23:25:22.304641064 -0800
+++ 25-akpm/security/security.c	2004-11-01 23:25:49.663481888 -0800
@@ -38,8 +38,8 @@ static inline int verify(struct security
 static void __init do_security_initcalls(void)
 {
 	initcall_t *call;
-	call = &__security_initcall_start;
-	while (call < &__security_initcall_end) {
+	call = __security_initcall_start;
+	while (call < __security_initcall_end) {
 		(*call) ();
 		call++;
 	}
_

