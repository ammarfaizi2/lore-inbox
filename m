Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWHSRTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWHSRTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 13:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWHSRTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 13:19:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51473 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161026AbWHSRTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 13:19:38 -0400
Date: Sat, 19 Aug 2006 19:19:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>, Matthew Wilcox <willy@parisc-linux.org>,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>
Subject: [2.6 patch] arch/parisc/Makefile: remove GCC_VERSION
Message-ID: <20060819171938.GK7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the usage of GCC_VERSION from arch/parisc/Makefile.

There are no functional changes, it simply makes it a bit shorter (and 
removes the last instance of GCC_VERSION in the kernel).

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Kyle McMartin <kyle@mcmartin.ca>

---

This patch was already sent on:
- 12 Jan 2006

--- linux-2.6.15-mm3-hppa/arch/parisc/Makefile.old	2006-01-12 03:11:45.000000000 +0100
+++ linux-2.6.15-mm3-hppa/arch/parisc/Makefile	2006-01-12 03:12:35.000000000 +0100
@@ -35,12 +35,8 @@
 
 OBJCOPY_FLAGS =-O binary -R .note -R .comment -S
 
-GCC_VERSION     := $(call cc-version)
-ifneq ($(shell if [ -z $(GCC_VERSION) ] ; then echo "bad"; fi ;),)
-$(error Sorry, couldn't find ($(cc-version)).)
-endif
-ifneq ($(shell if [ $(GCC_VERSION) -lt 0303 ] ; then echo "bad"; fi ;),)
-$(error Sorry, your compiler is too old ($(GCC_VERSION)).  GCC v3.3 or above is required.)
+ifneq ($(shell if [ $(call cc-version) -lt 0303 ] ; then echo "bad"; fi ;),)
+$(error Sorry, your compiler is too old.  GCC v3.3 or above is required.)
 endif
 
 cflags-y	:= -pipe

