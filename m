Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWHRPgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWHRPgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWHRPgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:36:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64171 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161015AbWHRPf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:35:58 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/7] FS-Cache: CacheFiles: ia64: missing copy_page export [try #12]
Date: Fri, 18 Aug 2006 16:35:16 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060818153516.29482.55752.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060818153502.29482.91650.stgit@warthog.cambridge.redhat.com>
References: <20060818153502.29482.91650.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one-line patch fixes the missing export of copy_page introduced
by the cachefile patches.  This patch is not yet upstream, but is required
for cachefile on ia64.  It will be pushed upstream when cachefile goes
upstream.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/ia64/kernel/ia64_ksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/ia64_ksyms.c b/arch/ia64/kernel/ia64_ksyms.c
index 3ead20f..6746a3e 100644
--- a/arch/ia64/kernel/ia64_ksyms.c
+++ b/arch/ia64/kernel/ia64_ksyms.c
@@ -42,6 +42,7 @@ EXPORT_SYMBOL(__do_clear_user);
 EXPORT_SYMBOL(__strlen_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
+EXPORT_SYMBOL(copy_page);
 
 /* from arch/ia64/lib */
 extern void __divsi3(void);
