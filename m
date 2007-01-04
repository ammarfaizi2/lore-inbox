Return-Path: <linux-kernel-owner+w=401wt.eu-S1030220AbXADVQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbXADVQP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbXADVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:16:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:55674 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030220AbXADVQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:16:14 -0500
Date: Thu, 4 Jan 2007 15:16:08 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 2/8] user namespace: add the framework
Message-ID: <20070104211608.GA21722@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181115.GC11377@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104181115.GC11377@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] user ns: fix compilation failures for some arches

for i386, an include of utsname.h by asm/elf.h hides the fact
that user_namespace needs sched.h.  To fix compilation for
x86_64, just include sched.h explicitly.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/user_namespace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index d577ede..be3e484 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -3,6 +3,7 @@ #define _LINUX_USER_NAMESPACE_H
 
 #include <linux/kref.h>
 #include <linux/nsproxy.h>
+#include <linux/sched.h>
 
 #define UIDHASH_BITS	(CONFIG_BASE_SMALL ? 3 : 8)
 #define UIDHASH_SZ	(1 << UIDHASH_BITS)
-- 
1.4.1

