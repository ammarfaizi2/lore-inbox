Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWFNOQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWFNOQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWFNOQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:16:10 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:22834 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964969AbWFNOP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:15:56 -0400
Date: Wed, 14 Jun 2006 16:06:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 20/24] s390: preempt_count initialization.
Message-ID: <20060614140620.GU9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] preempt_count initialization.

The preempt_count in the thread_info structure must be initialized to 1.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/thread_info.h |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/include/asm-s390/thread_info.h linux-2.6-patched/include/asm-s390/thread_info.h
--- linux-2.6/include/asm-s390/thread_info.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/thread_info.h	2006-06-14 14:29:59.000000000 +0200
@@ -63,6 +63,7 @@ struct thread_info {
 	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
 	.cpu		= 0,			\
+	.preempt_count	= 1,			\
 	.restart_block	= {			\
 		.fn = do_no_restart_syscall,	\
 	},					\
