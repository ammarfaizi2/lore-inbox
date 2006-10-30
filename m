Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWJ3MQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWJ3MQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWJ3MQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:16:04 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53939 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1751302AbWJ3MQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:16:01 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 30 Oct 2006 07:13:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] semaphore.h : remove unnecessary initializations of "sleepers"
 struct member
Message-ID: <Pine.LNX.4.64.0610300710520.7832@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Delete the irrelevant initializations of "sleepers" in the semaphore
initialization macro.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---
 asm-arm26/semaphore.h  |    1 -
 asm-h8300/semaphore.h  |    1 -
 asm-i386/semaphore.h   |    1 -
 asm-ia64/semaphore.h   |    1 -
 asm-m32r/semaphore.h   |    1 -
 asm-sh/semaphore.h     |    1 -
 asm-sh64/semaphore.h   |    1 -
 asm-sparc/semaphore.h  |    1 -
 asm-x86_64/semaphore.h |    1 -
 asm-xtensa/semaphore.h |    1 -
 10 files changed, 10 deletions(-)

diff --git a/include/asm-arm26/semaphore.h b/include/asm-arm26/semaphore.h
index 1fda543..2bab1d2 100644
--- a/include/asm-arm26/semaphore.h
+++ b/include/asm-arm26/semaphore.h
@@ -21,7 +21,6 @@ struct semaphore {
 #define __SEMAPHORE_INIT(name, n)					\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
 }

diff --git a/include/asm-h8300/semaphore.h b/include/asm-h8300/semaphore.h
index 81bae2a..0691963 100644
--- a/include/asm-h8300/semaphore.h
+++ b/include/asm-h8300/semaphore.h
@@ -31,7 +31,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-i386/semaphore.h b/include/asm-i386/semaphore.h
index 4e34a46..74c0e56 100644
--- a/include/asm-i386/semaphore.h
+++ b/include/asm-i386/semaphore.h
@@ -51,7 +51,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-ia64/semaphore.h b/include/asm-ia64/semaphore.h
index f483eeb..547b23a 100644
--- a/include/asm-ia64/semaphore.h
+++ b/include/asm-ia64/semaphore.h
@@ -20,7 +20,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-m32r/semaphore.h b/include/asm-m32r/semaphore.h
index 41e45d7..a55744f 100644
--- a/include/asm-m32r/semaphore.h
+++ b/include/asm-m32r/semaphore.h
@@ -27,7 +27,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-sh/semaphore.h b/include/asm-sh/semaphore.h
index 489f784..c7a8265 100644
--- a/include/asm-sh/semaphore.h
+++ b/include/asm-sh/semaphore.h
@@ -29,7 +29,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-sh64/semaphore.h b/include/asm-sh64/semaphore.h
index 4695264..3933993 100644
--- a/include/asm-sh64/semaphore.h
+++ b/include/asm-sh64/semaphore.h
@@ -36,7 +36,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-sparc/semaphore.h b/include/asm-sparc/semaphore.h
index f74ba31..3c49de5 100644
--- a/include/asm-sparc/semaphore.h
+++ b/include/asm-sparc/semaphore.h
@@ -18,7 +18,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC24_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-x86_64/semaphore.h b/include/asm-x86_64/semaphore.h
index 1194888..013ba50 100644
--- a/include/asm-x86_64/semaphore.h
+++ b/include/asm-x86_64/semaphore.h
@@ -52,7 +52,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

diff --git a/include/asm-xtensa/semaphore.h b/include/asm-xtensa/semaphore.h
index f10c348..80becb0 100644
--- a/include/asm-xtensa/semaphore.h
+++ b/include/asm-xtensa/semaphore.h
@@ -25,7 +25,6 @@ struct semaphore {
 #define __SEMAPHORE_INITIALIZER(name,n)					\
 {									\
 	.count		= ATOMIC_INIT(n),				\
-	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }

