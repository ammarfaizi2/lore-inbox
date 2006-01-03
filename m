Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWACNcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWACNcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWACNcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:32:11 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39173 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932353AbWACNZh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:37 -0500
Subject: [PATCH 10/26] kbuild: remove the deprecated check_gcc
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947252040@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: 1134516367 +0100

check_gcc has been deprecated for quite some time.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

cb1a7b4df7e2ffc7c97891e8f350ce5db50df3b9
diff --git a/Makefile b/Makefile
index c319144..b7856d3 100644
--- a/Makefile
+++ b/Makefile
@@ -286,10 +286,6 @@ export quiet Q KBUILD_VERBOSE
 cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
              > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
 
-# For backward compatibility
-check_gcc = $(warning check_gcc is deprecated - use cc-option) \
-            $(call cc-option, $(1),$(2))
-
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn, -march=winchip-c6)
 cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
-- 
1.0.6

