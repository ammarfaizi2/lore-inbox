Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWFNOZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWFNOZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWFNOZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:25:18 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:50866 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964974AbWFNOZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:25:16 -0400
Date: Wed, 14 Jun 2006 16:25:03 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 8/8] lock validator: add s390 to supported options
Message-ID: <20060614142503.GI1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Enable DEBUG_SPINLOCK_ALLOC, DEBUG_RWLOCK_ALLOC, DEBUG_MUTEX_ALLOC,
DEBUG_RWSEM_ALLOC and LOCKDEP for s390.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 lib/Kconfig.debug |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -purN a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug	2006-06-14 12:54:17.000000000 +0200
+++ b/lib/Kconfig.debug	2006-06-14 13:46:17.000000000 +0200
@@ -175,7 +175,7 @@ config DEBUG_SPINLOCK
 
 config DEBUG_SPINLOCK_ALLOC
 	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
-	depends on DEBUG_SPINLOCK && X86
+	depends on DEBUG_SPINLOCK && (X86 || S390)
 	select LOCKDEP
 	help
 	 This feature will check whether any held spinlock is incorrectly
@@ -224,7 +224,7 @@ config PROVE_SPIN_LOCKING
 
 config DEBUG_RWLOCK_ALLOC
 	bool "rw-lock debugging: detect incorrect freeing of live rwlocks"
-	depends on DEBUG_SPINLOCK && X86
+	depends on DEBUG_SPINLOCK && (X86 || S390)
 	select LOCKDEP
 	help
 	 This feature will check whether any held rwlock is incorrectly
@@ -281,7 +281,7 @@ config DEBUG_MUTEXES
 
 config DEBUG_MUTEX_ALLOC
 	bool "Mutex debugging: detect incorrect freeing of live mutexes"
-	depends on DEBUG_MUTEXES && X86
+	depends on DEBUG_MUTEXES && (X86 || S390)
 	select LOCKDEP
 	help
 	 This feature will check whether any held mutex is incorrectly
@@ -337,7 +337,7 @@ config DEBUG_RWSEMS
 
 config DEBUG_RWSEM_ALLOC
 	bool "rwsem debugging: detect incorrect freeing of live rwsems"
-	depends on DEBUG_RWSEMS && X86
+	depends on DEBUG_RWSEMS && (X86 || S390)
 	select LOCKDEP
 	help
 	 This feature will check whether any held rwsem is incorrectly
@@ -389,7 +389,7 @@ config LOCKDEP
 	select FRAME_POINTER
 	select KALLSYMS
 	select KALLSYMS_ALL
-	depends on X86
+	depends on X86 || S390
 
 config DEBUG_NON_NESTED_UNLOCKS
 	bool "Detect non-nested unlocks"
