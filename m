Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSFESx3>; Wed, 5 Jun 2002 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSFESx2>; Wed, 5 Jun 2002 14:53:28 -0400
Received: from mail.mplayerhq.hu ([192.190.173.45]:11193 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP
	id <S315856AbSFESx2>; Wed, 5 Jun 2002 14:53:28 -0400
Date: Wed, 5 Jun 2002 21:07:18 +0200 (CEST)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] use $(CONFIG_SHELL instead of . in Makefile
Message-ID: <Pine.LNX.4.33.0206052105440.11996-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sh ignores parameters when using . , so we should use $(CONFIG_SHELL)
instead.

patch is against 2.5.20

Bye,
Szabi

--- linux-2.5.20/Makefile.orig	Wed Jun  5 16:34:22 2002
+++ linux-2.5.20/Makefile	Wed Jun  5 16:50:18 2002
@@ -231,7 +231,7 @@

 include/linux/version.h: Makefile
 	@echo Generating $@
-	@. scripts/mkversion_h $@ $(KERNELRELEASE) $(VERSION) $(PATCHLEVEL) $(SUBLEVEL)
+	@$(CONFIG_SHELL) scripts/mkversion_h $@ $(KERNELRELEASE) $(VERSION) $(PATCHLEVEL) $(SUBLEVEL)

 # Helpers built in scripts/
 # ---------------------------------------------------------------------------

