Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWFWNah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWFWNah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWFWNag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:30:36 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:45605 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S964823AbWFWNaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:30:35 -0400
Date: Fri, 23 Jun 2006 15:30:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, klibc@zytor.com,
       linux-kernel@vger.kernel.org
Subject: [patch] s390: fix klibc build
Message-ID: <20060623133005.GI9446@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix s390 31 bit klibc build.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Patch is against 2.6.17-mm1.

 include/linux/kallsyms.h |   14 ++++++++++++++
 kernel/lockdep.c         |   38 ++++++++++++++------------------------
 kernel/stacktrace.c      |    4 +---
 3 files changed, 29 insertions(+), 27 deletions(-)

Index: linux-2.6.17-mm1/usr/klibc/arch/s390/Makefile.inc
===================================================================
--- linux-2.6.17-mm1.orig/usr/klibc/arch/s390/Makefile.inc
+++ linux-2.6.17-mm1/usr/klibc/arch/s390/Makefile.inc
@@ -13,6 +13,11 @@ KLIBCARCHOBJS = \
 	arch/$(KLIBCARCHDIR)/setjmp.o \
 	arch/$(KLIBCARCHDIR)/mmap.o \
 	arch/$(KLIBCARCHDIR)/syscall.o \
+	libgcc/__clzsi2.o \
+	libgcc/__clzdi2.o \
+	libgcc/__ashldi3.o \
+	libgcc/__ashrdi3.o \
+	libgcc/__lshrdi3.o \
 	libgcc/__divdi3.o \
 	libgcc/__moddi3.o \
 	libgcc/__udivdi3.o \
