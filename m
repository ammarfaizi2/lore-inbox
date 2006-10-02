Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWJBNMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWJBNMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWJBNMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:12:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4835 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932301AbWJBNMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:12:50 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/2] BLOCK: Fix linux/compat.h's use sigset_t
Date: Mon, 02 Oct 2006 14:12:34 +0100
To: torvalds@osdl.org, akpm@osdl.org, axboe@suse.de
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com>
References: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make linux/compat.h #include asm/signal.h to gain a definition of sigset_t so
that it can externally declare sigset_from_compat().

This has been compile-tested for i386, x86_64, ia64, mips, mips64, frv, ppc and
ppc64 and run-tested on frv.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/compat.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 967e748..ef5cd19 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -13,6 +13,7 @@ #include <linux/sem.h>
 
 #include <asm/compat.h>
 #include <asm/siginfo.h>
+#include <asm/signal.h>
 
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
