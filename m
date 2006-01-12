Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWALRQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWALRQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWALRQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:16:27 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:2437 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932238AbWALRQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:16:25 -0500
Date: Thu, 12 Jan 2006 18:15:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/13] s390: sigcontext.h vs __user.
Message-ID: <20060112171538.GG16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 6/13] s390: sigcontext.h vs __user.

Add an include of linux/compiler.h in sigcontext.h to avoid compiler
errors in user space apps because of a missing definition for __user.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 include/asm-s390/sigcontext.h |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/include/asm-s390/sigcontext.h linux-2.6-patched/include/asm-s390/sigcontext.h
--- linux-2.6/include/asm-s390/sigcontext.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/sigcontext.h	2006-01-12 15:43:56.000000000 +0100
@@ -8,6 +8,8 @@
 #ifndef _ASM_S390_SIGCONTEXT_H
 #define _ASM_S390_SIGCONTEXT_H
 
+#include <linux/compiler.h>
+
 #define __NUM_GPRS 16
 #define __NUM_FPRS 16
 #define __NUM_ACRS 16
