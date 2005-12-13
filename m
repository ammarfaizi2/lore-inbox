Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVLMX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVLMX0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLMX0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:26:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030300AbVLMX0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:26:08 -0500
Date: Wed, 14 Dec 2005 00:26:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove the deprecated check_gcc
Message-ID: <20051213232607.GX23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_gcc has been deprecated for quite some time.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Dec 2005

--- linux-2.6.15-rc3-mm1/Makefile.old	2005-12-03 02:50:54.000000000 +0100
+++ linux-2.6.15-rc3-mm1/Makefile	2005-12-03 02:51:05.000000000 +0100
@@ -286,10 +286,6 @@
 cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
              > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
 
-# For backward compatibility
-check_gcc = $(warning check_gcc is deprecated - use cc-option) \
-            $(call cc-option, $(1),$(2))
-
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn, -march=winchip-c6)
 cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \

